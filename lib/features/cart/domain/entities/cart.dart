import 'package:equatable/equatable.dart';
import '../../../crop/data/models/crop_model.dart';
import 'package:meta/meta.dart';

class Cart extends Equatable {
  Cart({
    @required this.crops,
    @required this.cropsToQuantity,
  });

  final List<CropModel> crops;
  final Map<int, int> cropsToQuantity;

  @override
  List<Object> get props => [crops, cropsToQuantity];

    @override
  String toString() {
    return 'Cart { crops: $crops, cropsToQuantity: $cropsToQuantity  }';
  }

}
