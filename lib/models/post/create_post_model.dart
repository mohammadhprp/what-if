import 'dart:io';

class CreatePostModel {
  final String? prompt;
  final String? caption;
  final File? image;

  CreatePostModel({
    this.prompt,
    this.caption,
    this.image,
  });

  CreatePostModel copyWithPrompt(String prompt) {
    return CreatePostModel(
      prompt: prompt,
      caption: caption,
      image: image,
    );
  }

  CreatePostModel copyWithCaption(String caption) {
    return CreatePostModel(
      prompt: prompt,
      caption: caption,
      image: image,
    );
  }

  CreatePostModel copyWithImage(File image) {
    return CreatePostModel(
      prompt: prompt,
      caption: caption,
      image: image,
    );
  }

  @override
  String toString() {
    return {
      "prompt": prompt,
      "caption": caption,
      "image": image?.path,
    }.toString();
  }
}
