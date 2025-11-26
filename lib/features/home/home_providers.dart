import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:mini_mart/models/product.dart';

final productsProvider = FutureProvider<List<Product>>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));

  const products = <Product>[
    // Fruits
    Product(
      id: 'f1',
      name: 'Strawberry Pack',
      price: 3.49,
      imageUrl:
          'https://thumbs.dreamstime.com/b/ripe-strawberry-isolated-white-background-single-red-berry-fresh-fruit-vertical-image-ripe-strawberry-isolated-white-401530685.jpg',
      rating: 4.7,
      category: 'Fruits',
    ),
    Product(
      id: 'f2',
      name: 'Fresh Apples',
      price: 2.49,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/11/18/13/47/apple-1834639_640.jpg',
      rating: 4.6,
      category: 'Fruits',
    ),
    Product(
      id: 'f3',
      name: 'Watermelon Slice',
      price: 4.99,
      imageUrl:
          'https://thumbs.dreamstime.com/b/watermelon-slices-wooden-table-55476817.jpg',
      rating: 4.4,
      category: 'Fruits',
    ),
    Product(
      id: 'f4',
      name: 'Bananas Bunch',
      price: 1.99,
      imageUrl:
          'https://media.istockphoto.com/id/157375066/photo/banana.jpg?s=612x612&w=0&k=20&c=3v7si4IY-VZRIiUnG2fUodH2kIF4ipt06YnrtBCF3nc=',
      rating: 4.5,
      category: 'Fruits',
    ),
    Product(
      id: 'f5',
      name: 'Pineapple',
      price: 2.99,
      imageUrl:
          'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZnJ1aXR8ZW58MHx8MHx8fDA%3D',
      rating: 4.3,
      category: 'Fruits',
    ),
    Product(
      id: 'f6',
      name: 'Papaya',
      price: 2.29,
      imageUrl: 'https://thumbs.dreamstime.com/b/papaya-fruits-14403910.jpg',
      rating: 4.1,
      category: 'Fruits',
    ),
    Product(
      id: 'f7',
      name: 'Avocado',
      price: 3.99,
      imageUrl:
          'https://images.pexels.com/photos/557659/pexels-photo-557659.jpeg?cs=srgb&dl=pexels-foodie-factor-162291-557659.jpg&fm=jpg',
      rating: 4.6,
      category: 'Fruits',
    ),
    Product(
      id: 'f8',
      name: 'Oranges Bag',
      price: 2.79,
      imageUrl:
          'https://images.pexels.com/photos/161559/background-bitter-breakfast-bright-161559.jpeg?cs=srgb&dl=pexels-pixabay-161559.jpg&fm=jpg',
      rating: 4.5,
      category: 'Fruits',
    ),

    // Vegetables
    Product(
      id: 'v1',
      name: 'Tomatoes 1kg',
      price: 1.49,
      imageUrl:
          'https://t4.ftcdn.net/jpg/05/37/04/61/360_F_537046123_s8JVn2NrClPQDOryhSm8jonYZPfIzPRX.jpg',
      rating: 4.2,
      category: 'Vegetables',
    ),
    Product(
      id: 'v2',
      name: 'Cauliflower',
      price: 1.99,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXo1pTXhMFZ52F1Ydkf5Qd7yrdSOrGfYMIQA&s',
      rating: 4.1,
      category: 'Vegetables',
    ),
    Product(
      id: 'v3',
      name: 'Pumpkin',
      price: 2.39,
      imageUrl:
          'https://media.istockphoto.com/id/1058023252/photo/pumpkin-isolated-on-white-background.jpg?s=612x612&w=0&k=20&c=VYFBd-A2d-zPNP4DWPMz-PUBIDP96cQUHqyq15-TOaA=',
      rating: 4.0,
      category: 'Vegetables',
    ),
    Product(
      id: 'v4',
      name: 'Broccoli',
      price: 2.19,
      imageUrl:
          'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8dmVnZXRhYmxlfGVufDB8fDB8fHww',
      rating: 4.4,
      category: 'Vegetables',
    ),
    Product(
      id: 'v5',
      name: 'Cabbage',
      price: 1.29,
      imageUrl:
          'https://foodcare.in/cdn/shop/products/cabege.png?v=1725364170',
      rating: 4.1,
      category: 'Vegetables',
    ),

    // Dairy
    Product(
      id: 'd1',
      name: 'Milk 1L',
      price: 0.99,
      imageUrl:
          'https://images.pexels.com/photos/248412/pexels-photo-248412.jpeg?cs=srgb&dl=pexels-pixabay-248412.jpg&fm=jpg',
      rating: 4.8,
      category: 'Dairy',
    ),
    Product(
      id: 'd2',
      name: 'Paneer 200g',
      price: 2.49,
      imageUrl:
          'https://5.imimg.com/data5/ANDROID/Default/2023/3/EH/YT/EO/108385388/product-jpeg.jpg',
      rating: 4.6,
      category: 'Dairy',
    ),
    Product(
      id: 'd3',
      name: 'Curd Tub',
      price: 1.59,
      imageUrl:
          'https://m.media-amazon.com/images/I/61ShbpBieaL._AC_UF894,1000_QL80_.jpg',
      rating: 4.5,
      category: 'Dairy',
    ),
    Product(
      id: 'd4',
      name: 'Milk Biscuits',
      price: 1.99,
      imageUrl:
          'https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto/NI_CATALOG/IMAGES/CIW/2024/3/28/d4281821-82de-4ea4-b03b-648db54d6c5d_biscuits_AGR68GDYRO_AL3.png',
      rating: 4.3,
      category: 'Dairy',
    ),
    Product(
      id: 'd5',
      name: 'Fluffy Yogurt Biscuits',
      price: 2.29,
      imageUrl:
          'https://images.squarespace-cdn.com/content/v1/6508404030fe0519d54c5c79/a0465deb-84ea-469f-aa5c-fe4f96aa088f/Fluffy-Yogurt-Biscuits_TTU.png',
      rating: 4.2,
      category: 'Dairy',
    ),
    Product(
      id: 'd6',
      name: 'BelleAme Cremo Biscuits',
      price: 2.59,
      imageUrl:
          'https://i.ytimg.com/vi/g34FduSeZIc/sddefault.jpg',
      rating: 4.1,
      category: 'Dairy',
    ),

    // Snacks
    Product(
      id: 's1',
      name: 'Potato Chips',
      price: 1.49,
      imageUrl:
          'https://assets.clevelandclinic.org/transform/LargeFeatureImage/cac33a9c-7121-4073-97ac-99fbc27acba1/worstSnacks-527905022-770x533-1_jpg',
      rating: 4.0,
      category: 'Snacks',
    ),
    Product(
      id: 's2',
      name: 'Instant Noodles',
      price: 0.89,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBmvgAeYdLjvD0cBf4KtsYUPwlMUFXNr-4L2WUFQtrdSYxNSrjg3A3NdnmAGsg6my-vog&usqp=CAU',
      rating: 4.3,
      category: 'Snacks',
    ),
    Product(
      id: 's3',
      name: 'Popcorn Tub',
      price: 1.99,
      imageUrl:
          'https://png.pngtree.com/png-clipart/20240911/original/pngtree-popcorn-bucket-realistic-pop-corn-container-png-image_15988652.png',
      rating: 4.4,
      category: 'Snacks',
    ),
    Product(
      id: 's4',
      name: 'Assorted Cookies',
      price: 2.49,
      imageUrl:
          'https://thumbs.dreamstime.com/z/assorted-cookies-arranged-plate-variety-flavors-types-ready-to-be-enjoyed-everyone-387455714.jpg',
      rating: 4.5,
      category: 'Snacks',
    ),
  ];

  return products;
});

final selectedCategoryProvider = StateProvider<String>((ref) => 'All');

final searchQueryProvider = StateProvider<String>((ref) => '');

