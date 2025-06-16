// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductModelAdapter extends TypeAdapter<ProductModel> {
  @override
  final int typeId = 0;

  @override
  ProductModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductModel(
      id: fields[0] as String,
      title: fields[1] as String,
      subtitle: fields[2] as String?,
      description: fields[3] as String,
      handle: fields[4] as String,
      isGiftCard: fields[5] as bool,
      discountable: fields[6] as bool,
      thumbnail: fields[7] as String,
      type: fields[8] as ProductType,
      collection: fields[9] as ProductCollection?,
      options: (fields[10] as List).cast<ProductOption>(),
      tags: (fields[11] as List).cast<String>(),
      images: (fields[12] as List).cast<ProductImage>(),
      variants: (fields[13] as List).cast<ProductVariant>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductModel obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.subtitle)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.handle)
      ..writeByte(5)
      ..write(obj.isGiftCard)
      ..writeByte(6)
      ..write(obj.discountable)
      ..writeByte(7)
      ..write(obj.thumbnail)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.collection)
      ..writeByte(10)
      ..write(obj.options)
      ..writeByte(11)
      ..write(obj.tags)
      ..writeByte(12)
      ..write(obj.images)
      ..writeByte(13)
      ..write(obj.variants);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductVariantAdapter extends TypeAdapter<ProductVariant> {
  @override
  final int typeId = 1;

  @override
  ProductVariant read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVariant(
      id: fields[0] as String,
      title: fields[1] as String,
      allowBackorder: fields[2] as bool,
      manageInventory: fields[3] as bool,
      variantRank: fields[4] as int,
      options: (fields[5] as List).cast<OptionValue>(),
      calculatedPrice: fields[6] as CalculatedPrice?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductVariant obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.allowBackorder)
      ..writeByte(3)
      ..write(obj.manageInventory)
      ..writeByte(4)
      ..write(obj.variantRank)
      ..writeByte(5)
      ..write(obj.options)
      ..writeByte(6)
      ..write(obj.calculatedPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariantAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OptionValueAdapter extends TypeAdapter<OptionValue> {
  @override
  final int typeId = 2;

  @override
  OptionValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionValue(
      id: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OptionValue obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductTypeAdapter extends TypeAdapter<ProductType> {
  @override
  final int typeId = 3;

  @override
  ProductType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductType(
      id: fields[0] as String,
      value: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductCollectionAdapter extends TypeAdapter<ProductCollection> {
  @override
  final int typeId = 4;

  @override
  ProductCollection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductCollection(
      id: fields[0] as String?,
      title: fields[1] as String?,
      handle: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductCollection obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.handle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductCollectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductOptionAdapter extends TypeAdapter<ProductOption> {
  @override
  final int typeId = 5;

  @override
  ProductOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductOption(
      id: fields[0] as String,
      title: fields[1] as String,
      values: (fields[2] as List).cast<OptionValue>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProductOption obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.values);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductImageAdapter extends TypeAdapter<ProductImage> {
  @override
  final int typeId = 6;

  @override
  ProductImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductImage(
      id: fields[0] as String,
      url: fields[1] as String,
      rank: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProductImage obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.url)
      ..writeByte(2)
      ..write(obj.rank);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CalculatedPriceAdapter extends TypeAdapter<CalculatedPrice> {
  @override
  final int typeId = 7;

  @override
  CalculatedPrice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalculatedPrice(
      calculatedAmount: fields[0] as int,
      originalAmount: fields[1] as int,
      currencyCode: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CalculatedPrice obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.calculatedAmount)
      ..writeByte(1)
      ..write(obj.originalAmount)
      ..writeByte(2)
      ..write(obj.currencyCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalculatedPriceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
