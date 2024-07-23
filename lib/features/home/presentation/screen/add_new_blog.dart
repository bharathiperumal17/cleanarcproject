import 'dart:io';

import 'package:cleanarcproject/core/common/utils/pick_image.dart';
import 'package:cleanarcproject/core/common/utils/show_snack_bar.dart';
import 'package:cleanarcproject/core/common/widget/cubit/app_user_cubit/appuser_cubit.dart';
import 'package:cleanarcproject/core/common/widget/loader.dart';
import 'package:cleanarcproject/core/theme/app_pallete.dart';
import 'package:cleanarcproject/features/home/presentation/bloc/bloc/blog_bloc.dart';
import 'package:cleanarcproject/features/home/presentation/widget/blog_editter.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  TextEditingController blogTitle = TextEditingController();
  TextEditingController content = TextEditingController();
  final formkey = GlobalKey<FormState>();
  List<String> selectedTopic = [];
  File? image;
  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFaliure) {
          showSnackBar(context, state.fmessage);
        } else if (state is BlogSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is BlogLoading) {
          return const CircularLoader();
        }
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    if (formkey.currentState!.validate() &&
                        selectedTopic.isNotEmpty &&
                        image != null) {
                      final posterID = (context.read<AppuserCubit>().state)
                          as AppUserLoggedIn;
                      context.read<BlogBloc>().add(BlogUpload(
                          posterId: posterID.user.email,
                          content: content.text.trim(),
                          title: blogTitle.text.trim(),
                          file: File(image!.path),
                          topics: selectedTopic));
                    }
                  },
                  icon: const Icon(Icons.done_rounded))
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      image!.path,
                                      fit: BoxFit.cover,
                                    ))),
                          )
                        : GestureDetector(
                            onTap: selectImage,
                            child: DottedBorder(
                                color: AppPallete.borderColor,
                                dashPattern: const [10, 4],
                                borderType: BorderType.RRect,
                                strokeCap: StrokeCap.round,
                                radius: const Radius.circular(10),
                                child: const SizedBox(
                                  height: 150,
                                  width: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.folder_open,
                                        size: 40,
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('Select Your image ')
                                    ],
                                  ),
                                )),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: [
                        'Technology',
                        'Business',
                        'Programming',
                        'Entertainment',
                        'Favorites'
                      ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        if (selectedTopic.contains(e)) {
                                          selectedTopic.remove(e);
                                        } else {
                                          selectedTopic.add(e);
                                        }
                                        setState(() {});
                                      },
                                      child: Chip(
                                          color: selectedTopic.contains(e)
                                              ? const MaterialStatePropertyAll(
                                                  AppPallete.gradient2)
                                              : null,
                                          side: selectedTopic.contains(e)
                                              ? null
                                              : const BorderSide(
                                                  color:
                                                      AppPallete.borderColor),
                                          label: Text(e)),
                                    ),
                                  ))
                              .toList()),
                    ),
                    BlogEditter(controller: blogTitle, hintText: 'Blog Title'),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditter(controller: content, hintText: 'Blog Content')
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    blogTitle.dispose();
    content.dispose();
  }
}
