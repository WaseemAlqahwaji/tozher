import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tozher/features/core/constants/app_constants.dart';
import 'package:tozher/features/core/domain/entity/base_state.dart';
import 'package:tozher/features/core/presentation/widgets/loading_widget.dart';
import 'package:tozher/features/core/presentation/widgets/reusable_bloc_listner.dart';
import 'package:tozher/features/image_upload/presentation/cubit/image_upload_cubit.dart';
import 'package:tozher/features/interests/domain/entity/interest.dart';
import 'package:tozher/features/interests/presentation/cubit/interest_get_cubit.dart';
import 'package:tozher/features/posts/domain/params/post_add_params.dart';
import 'package:tozher/features/posts/presentation/cubit/post_add_cubit.dart';
import 'package:tozher/generated/l10n.dart';
import 'package:tozher/injection.dart';

class PostAddPage extends StatefulWidget {
  const PostAddPage({super.key});

  @override
  State<PostAddPage> createState() => _PostAddPageState();
}

class _PostAddPageState extends State<PostAddPage> {
  late TextEditingController _titleController;
  final _formKey = GlobalKey<FormState>();
  List<File> _selectedImages = [];
  final ImagePicker _picker = ImagePicker();
  bool _isUploadingImages = false;
  Interest? _selectedInterest;

  final postAddCubit = getIt<PostAddCubit>();
  final imageUploadCubit = getIt<ImageUploadCubit>();
  final interestGetCubit = getIt<InterestGetCubit>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    interestGetCubit.getInterests();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages = images.map((x) => File(x.path)).toList();
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _handlePost() async {
    if (!_formKey.currentState!.validate()) return;
    final title = _titleController.text.trim();

    List<String> photoUrls = [];

    if (_selectedImages.isNotEmpty) {
      setState(() => _isUploadingImages = true);

      final imagePaths = _selectedImages.map((f) => f.path).toList();
      imageUploadCubit.uploadImages(imagePaths);

      await for (final state in imageUploadCubit.stream) {
        if (state.isFailure) {
          setState(() => _isUploadingImages = false);
          return;
        }
        if (state.isSuccess) {
          photoUrls = state.item!.map((img) => img.url).toList();
          break;
        }
      }

      setState(() => _isUploadingImages = false);
      if (photoUrls.isEmpty) return;
    }

    postAddCubit.addPost(
      PostAddParams(
        title: title,
        photos: photoUrls,
        likeCount: 0,
        interest: _selectedInterest,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appName),
        centerTitle: true,
        actions: [
          ReusableBlocListener<PostAddCubit, void>(
            cubit: postAddCubit,
            onSuccess: (_) => context.pop(),
            child: TextButton(
              onPressed: _handlePost,
              child: Text(
                strings.post,
                style: TextStyle(
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.pagePadding),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    hintText: strings.whatsOnYourMind,
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                  minLines: 3,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return strings.fieldRequired;
                    }
                    return null;
                  },
                ),
                Gap(16.h),

                // Image upload area
                GestureDetector(
                  onTap: _pickImages,
                  child: Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.primaryColor.withValues(alpha: .4),
                        style: BorderStyle.solid,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          size: 32.sp,
                          color: theme.primaryColor,
                        ),
                        Gap(4.h),
                        Text(
                          strings.addPhotos,
                          style: TextStyle(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Selected images grid
                if (_selectedImages.isNotEmpty) ...[
                  Gap(12.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _selectedImages.asMap().entries.map((entry) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              entry.value,
                              width: 80.w,
                              height: 80.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _removeImage(entry.key),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],

                Gap(24.h),

                // Mention Interests section
                Text(
                  strings.mentionInterests,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(8.h),
                BlocBuilder<InterestGetCubit, BaseState<List<Interest>>>(
                  bloc: interestGetCubit,
                  builder: (context, state) {
                    if (state.isInProgress) {
                      return const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: LoadingWidget()),
                      );
                    }
                    if (state.isFailure) {
                      return Text(strings.errorHappend);
                    }
                    final interests = state.item ?? [];
                    if (interests.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: interests.map((interest) {
                        final isSelected = _selectedInterest?.id == interest.id;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedInterest = isSelected ? null : interest;
                            });
                          },
                          child: _InterestChip(
                            label: interest.name,
                            isSelected: isSelected,
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),

                // Upload loading
                if (_isUploadingImages) ...[
                  Gap(16.h),
                  const Center(child: LoadingWidget()),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InterestChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _InterestChip({required this.label, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: isSelected
            ? theme.primaryColor
            : theme.primaryColor.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: theme.primaryColor.withValues(alpha: .3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.emoji_events,
            size: 14.sp,
            color: isSelected ? Colors.white : null,
          ),
          Gap(6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ],
      ),
    );
  }
}
