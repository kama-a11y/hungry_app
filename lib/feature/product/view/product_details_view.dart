import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungryapp/core/constants/app_color.dart';
import 'package:hungryapp/core/network/api_error.dart';
import 'package:hungryapp/core/utils/pref_helper.dart';
import 'package:hungryapp/feature/auth/view/login_view.dart';
import 'package:hungryapp/feature/home/data/product_model.dart';
import 'package:hungryapp/feature/product/data/option_model.dart';
import 'package:hungryapp/feature/product/data/product_repo.dart';
import 'package:hungryapp/feature/product/widget/spicy_slider.dart';
import 'package:hungryapp/feature/product/widget/topping_item.dart';
import 'package:hungryapp/shared/custom_button.dart';
import 'package:hungryapp/shared/custom_snack_bar.dart';
import 'package:hungryapp/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({super.key, required this.id});
  final int id;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = .5;
  int quantity = 1;

  List<int> toppingIds = [];
  List<int> optionIds = [];

  bool addLoading = false;
  bool isGuest = false;
  bool isCheckingGuest = true;

  ProductModel? productModel;
  List<OptionModel>? toppings;
  List<OptionModel>? sideOptions;

  ProductRepo productRepo = ProductRepo();

  /// check guest mode first
  Future<void> checkGuestStatus() async {
    final guest = await PrefHelper.isGuestMode();

    if (!mounted) return;

    setState(() {
      isGuest = guest;
      isCheckingGuest = false;
    });

    /// هنا حتى لو Guest ممكن نخليه يشوف تفاصيل المنتج عادي
    /// عشان كده هنجيب الداتا في الحالتين
    await Future.wait([
      getProductInfo(),
      getToppings(),
      getSideOptions(),
    ]);
  }

  /// get product info
  Future<void> getProductInfo() async {
    try {
      final product = await productRepo.getProductInfo(widget.id + 1);

      if (!mounted) return;

      setState(() {
        productModel = product;
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = 'Error loading product';
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );
    }
  }

  /// get toppings
  Future<void> getToppings() async {
    try {
      final result = await productRepo.getToppings();

      if (!mounted) return;

      setState(() {
        toppings = result;
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = 'Error loading toppings';
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );
    }
  }

  /// get side options
  Future<void> getSideOptions() async {
    try {
      final result = await productRepo.getSideOptions();

      if (!mounted) return;

      setState(() {
        sideOptions = result;
      });
    } catch (e) {
      if (!mounted) return;

      String errorMsg = 'Error loading side options';
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );
    }
  }

  /// add to cart
  Future<void> addToCart() async {
    setState(() {
      addLoading = true;
    });

    try {
      await productRepo.addToCart(
        productId: widget.id + 1,
        quantity: quantity,
        spicy: value,
        toppings: toppingIds,
        sideOptions: optionIds,
      );

      if (!mounted) return;

      setState(() {
        addLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar('Added to cart successfully', true),
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        addLoading = false;
      });

      String errorMsg = 'Error while adding to cart';
      if (e is ApiError) {
        errorMsg = e.message;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(errorMsg, false),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    checkGuestStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (isCheckingGuest) {
      return const Scaffold(
        body: Center(
          child: CupertinoActivityIndicator(),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await Future.wait([
          getProductInfo(),
          getToppings(),
          getSideOptions(),
          checkGuestStatus(),
        ]);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
        ),
        body: Skeletonizer(
          enabled: productModel == null || toppings == null || sideOptions == null,
          child: _buildRealUI(),
        ),
      ),
    );
  }

  /// loading UI
  Widget _buildLoadingUI() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          SizedBox(height: 250, width: double.infinity),
          Gap(40),
          SizedBox(height: 20, width: 150),
          Gap(20),
          SizedBox(height: 80, width: double.infinity),
        ],
      ),
    );
  }

  /// real UI
  Widget _buildRealUI() {
    if (productModel == null || toppings == null || sideOptions == null) {
      return _buildLoadingUI();
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpicySlider(
              value: value,
              onChanged: (v) {
                setState(() {
                  value = v;
                });
              },
              image: productModel!.image,
              name: productModel!.name,
              description: productModel!.description,
            ),
            const Gap(40),

            /// Toppings
            CustomText(
              text: 'Toppings',
              size: 18,
              weight: FontWeight.bold,
            ),
            const Gap(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              child: Row(
                children: (toppings ?? []).map((item) {
                  final isToppingClicked = toppingIds.contains(item.id);

                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: ToppingItem(
                      image: item.image,
                      title: item.name,
                      isclicked: isToppingClicked,
                      ontap: () {
                        setState(() {
                          if (isToppingClicked) {
                            toppingIds.remove(item.id);
                          } else {
                            toppingIds.add(item.id);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const Gap(40),

            /// Side options
            CustomText(
              text: 'Side options',
              size: 18,
              weight: FontWeight.bold,
            ),
            const Gap(20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              clipBehavior: Clip.none,
              child: Row(
                children: (sideOptions ?? []).map((item) {
                  final isOptionClicked = optionIds.contains(item.id);

                  return Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: ToppingItem(
                      image: item.image,
                      title: item.name,
                      isclicked: isOptionClicked,
                      ontap: () {
                        setState(() {
                          if (isOptionClicked) {
                            optionIds.remove(item.id);
                          } else {
                            optionIds.add(item.id);
                          }
                        });

                        print('option list is : $optionIds');
                      },
                    ),
                  );
                }).toList(),
              ),
            ),

            const Gap(50),

            /// لو Guest -> رسالة + زر Login
            if (isGuest) ...[
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 70,
                        color: AppColor.primaryColor.withOpacity(.4),
                      ),
                      const SizedBox(height: 15),
                      CustomText(
                        text: 'Please login to add this product to cart',
                        size: 18,
                        weight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                      const SizedBox(height: 10),
                      CustomText(
                        text: 'Guests can browse products, but adding to cart requires login',
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                      const SizedBox(height: 25),
                      CustomButton(
                        text: 'Go To Login',
                        width: double.infinity,
                        height: 55,
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginView(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(40),
            ] else ...[
              /// Total + Add To Cart
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Total',
                        size: 20,
                        weight: FontWeight.bold,
                      ),
                      const Gap(10),
                      Row(
                        children: [
                          Icon(
                            CupertinoIcons.money_dollar,
                            color: AppColor.primaryColor,
                            size: 40,
                          ),
                          CustomText(
                            text: productModel!.price,
                            size: 26,
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  CustomButton(
                    text: addLoading ? 'Adding...' : 'Add To Cart',
                    width: 200,
                    height: 70,
                    ontap: addLoading ? null : () => addToCart(),
                  ),
                ],
              ),
              const Gap(40),
            ],
          ],
        ),
      ),
    );
  }
}