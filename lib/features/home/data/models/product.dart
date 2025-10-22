class Product {
	String? id;
	String? productCode;
	String? name;
	String? description;
	String? arabicName;
	String? arabicDescription;
	String? coverPictureUrl;
	dynamic productPictures;
	double? price;
	int? stock;
	double? weight;
	String? color;
	int? rating;
	int? reviewsCount;
	int? discountPercentage;
	String? sellerId;
	List<String>? categories;

	Product({
		this.id, 
		this.productCode, 
		this.name, 
		this.description, 
		this.arabicName, 
		this.arabicDescription, 
		this.coverPictureUrl, 
		this.productPictures, 
		this.price, 
		this.stock, 
		this.weight, 
		this.color, 
		this.rating, 
		this.reviewsCount, 
		this.discountPercentage, 
		this.sellerId, 
		this.categories, 
	});

	factory Product.fromJson(Map<String, dynamic> json) => Product(
				id: json['id'] as String?,
				productCode: json['productCode'] as String?,
				name: json['name'] as String?,
				description: json['description'] as String?,
				arabicName: json['arabicName'] as String?,
				arabicDescription: json['arabicDescription'] as String?,
				coverPictureUrl: json['coverPictureUrl'] as String?,
				productPictures: json['productPictures'] as dynamic,
				price: (json['price'] as num?)?.toDouble(),
				stock: json['stock'] as int?,
				weight: (json['weight'] as num?)?.toDouble(),
				color: json['color'] as String?,
				rating: json['rating'] as int?,
				reviewsCount: json['reviewsCount'] as int?,
				discountPercentage: json['discountPercentage'] as int?,
				sellerId: json['sellerId'] as String?,
				categories: json['categories'] as List<String>?,
			);

	Map<String, dynamic> toJson() => {
				'id': id,
				'productCode': productCode,
				'name': name,
				'description': description,
				'arabicName': arabicName,
				'arabicDescription': arabicDescription,
				'coverPictureUrl': coverPictureUrl,
				'productPictures': productPictures,
				'price': price,
				'stock': stock,
				'weight': weight,
				'color': color,
				'rating': rating,
				'reviewsCount': reviewsCount,
				'discountPercentage': discountPercentage,
				'sellerId': sellerId,
				'categories': categories,
			};
}
