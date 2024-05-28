import 'package:flutter_inf_app/common/model/model_with_id.dart';
import 'package:flutter_inf_app/common/utils/data_utils.dart';
import 'package:flutter_inf_app/user/model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'rating_model.g.dart';

@JsonSerializable()
class RatingModel implements IModelWithId {
  @override
  final String id;
  final UserModel user;
  final int rating;
  final String content;
  @JsonKey(fromJson: DataUtils.listPathsToUrls)
  final List<String> images;

  RatingModel({
    required this.id,
    required this.user,
    required this.rating,
    required this.content,
    required this.images,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      _$RatingModelFromJson(json);
}
