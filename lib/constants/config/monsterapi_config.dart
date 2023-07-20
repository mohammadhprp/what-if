class MonsterapiConfig {
  static const xApiKey = "x-api-key";
  static const authorization = "Authorization";

  static const model = Model.txt2img;

  static const negativePrompt =
      "lowers, signs, memes, labels, text, food, text,"
      " error, mutant, cropped, worst quality, low quality, "
      "normal quality, jpeg artifacts, signature, watermark, "
      "username, blurry, made by children, caricature, ugly, "
      "boring, sketch, lackluster, repetitive, cropped, "
      "(long neck), facebook, youtube, body horror, out of frame,"
      " mutilated, tiled, frame, border, porcelain skin, doll like,"
      " doll, bad quality, cartoon, lowers, meme, low quality, worst "
      "quality, ugly, disfigured, inhuman";

  /// Allowed range: 1-4
  static const samples = 1;

  /// Allowed range 30-500
  static const steps = 100;

  /// Allowed values: square, landscape, portrait
  static const aspectRatio = AspectRatio.landscape;

  static const guidanceScale = 12.5;

  static const seed = 2333;
}

enum AspectRatio {
  square,
  landscape,
  portrait,
}

enum Model {
  txt2img,
  img2img,
}
