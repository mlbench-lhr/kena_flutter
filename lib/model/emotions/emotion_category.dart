import 'package:flutter/material.dart';
import 'package:kena/generated/assets/assets.gen.dart';

// ─── Models ───────────────────────────────────────────────────────────────────

class EmotionCategory {
  final String title;
  final Color color;
  final Widget Function(double w, double h) emojiBuilder;
  final List<SubEmotion> subEmotions;

  EmotionCategory({
    required this.title,
    required this.color,
    required this.emojiBuilder,
    required this.subEmotions,
  });
}

class SubEmotion {
  final String title;
  final Widget Function(double w, double h) emojiBuilder;

  SubEmotion({required this.title, required this.emojiBuilder});
}

// ─── Data ─────────────────────────────────────────────────────────────────────

final List<EmotionCategory> emotionCategories = [
  EmotionCategory(
    title: "Sad",
    color: Color(0xFFe9eaff),
    emojiBuilder: (w, h) => Assets.images.cryingFace.image(width: w, height: h),
    subEmotions: [
      SubEmotion(
        title: "Lonely",
        emojiBuilder: (w, h) =>
            Assets.images.cryingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Depressed",
        emojiBuilder: (w, h) =>
            Assets.images.sadFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Ashamed",
        emojiBuilder: (w, h) => Assets.images.kia.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Guilty",
        emojiBuilder: (w, h) =>
            Assets.images.sadFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Bored",
        emojiBuilder: (w, h) =>
            Assets.images.expressionlessFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Spleepy",
        emojiBuilder: (w, h) =>
            Assets.images.sleepingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Apathetic",
        emojiBuilder: (w, h) =>
            Assets.images.faceWithoutMouth.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Inferior",
        emojiBuilder: (w, h) =>
            Assets.images.pleadingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Inadequate",
        emojiBuilder: (w, h) =>
            Assets.images.cryingCat.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Miserable",
        emojiBuilder: (w, h) => Assets
            .images
            .anxiousFaceWithWorriedNervousConcerned
            .image(width: w, height: h),
      ),
      SubEmotion(
        title: "Bashful",
        emojiBuilder: (w, h) =>
            Assets.images.faceWithPeekingEye.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Stupid",
        emojiBuilder: (w, h) =>
            Assets.images.aPersonFacepalming.image(width: w, height: h),
      ),
    ],
  ),
  EmotionCategory(
    title: "Joyful",
    color: Color(0xFFffebb9),
    emojiBuilder: (w, h) => Assets.images.heartsFace.image(width: w, height: h),
    subEmotions: [
      SubEmotion(
        title: "Excited",
        emojiBuilder: (w, h) =>
            Assets.images.starStruck.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Sexy",
        emojiBuilder: (w, h) =>
            Assets.images.smileOverhand.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Energetic",
        emojiBuilder: (w, h) =>
            Assets.images.aHighVoltage.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Playful",
        emojiBuilder: (w, h) =>
            Assets.images.performingArts.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Creative",
        emojiBuilder: (w, h) =>
            Assets.images.artistPalette.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Aware",
        emojiBuilder: (w, h) => Assets.images.eye.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Daring",
        emojiBuilder: (w, h) =>
            Assets.images.lionFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Fascinating",
        emojiBuilder: (w, h) =>
            Assets.images.sparkles.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Stimulating",
        emojiBuilder: (w, h) =>
            Assets.images.glowingStar.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Amused",
        emojiBuilder: (w, h) =>
            Assets.images.meltingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Delighted",
        emojiBuilder: (w, h) => Assets.images.smile.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Extravagant",
        emojiBuilder: (w, h) =>
            Assets.images.shakingFace.image(width: w, height: h),
      ),
    ],
  ),
  EmotionCategory(
    title: "Scared",
    color: Color(0xFFffe8f5),
    emojiBuilder: (w, h) =>
        Assets.images.fearfulFace.image(width: w, height: h),
    subEmotions: [
      SubEmotion(
        title: "Anxious",
        emojiBuilder: (w, h) => Assets
            .images
            .anxiousFaceWithWorriedNervousConcerned
            .image(width: w, height: h),
      ),
      SubEmotion(
        title: "Insecure",
        emojiBuilder: (w, h) =>
            Assets.images.worriedFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Submissive",
        emojiBuilder: (w, h) =>
            Assets.images.manBowing.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Helpless",
        emojiBuilder: (w, h) =>
            Assets.images.anguishedFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Confused",
        emojiBuilder: (w, h) =>
            Assets.images.dizzyFaceCrossOnEye.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Rejected",
        emojiBuilder: (w, h) =>
            Assets.images.heartbreak.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Skeptical",
        emojiBuilder: (w, h) =>
            Assets.images.faceWithEyebrow.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Bewildered",
        emojiBuilder: (w, h) =>
            Assets.images.amazing.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Discouraged",
        emojiBuilder: (w, h) =>
            Assets.images.disappointedFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Insignificant",
        emojiBuilder: (w, h) =>
            Assets.images.dottedLineFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Weak",
        emojiBuilder: (w, h) => Assets.images.crying.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Foolish",
        emojiBuilder: (w, h) => Assets.images.joker.image(width: w, height: h),
      ),
    ],
  ),
  EmotionCategory(
    title: "Peaceful",
    color: Color(0xFFd3eef2),
    emojiBuilder: (w, h) =>
        Assets.images.smilingFace.image(width: w, height: h),
    subEmotions: [
      SubEmotion(
        title: "Content",
        emojiBuilder: (w, h) =>
            Assets.images.relievedFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Thoughtful",
        emojiBuilder: (w, h) =>
            Assets.images.thinkingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Intimate",
        emojiBuilder: (w, h) =>
            Assets.images.twoHearts.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Loving",
        emojiBuilder: (w, h) =>
            Assets.images.heartsFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Nurturing",
        emojiBuilder: (w, h) => Assets.images.cherry.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Trusting",
        emojiBuilder: (w, h) =>
            Assets.images.aHandshake.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Relaxed",
        emojiBuilder: (w, h) =>
            Assets.images.sleepingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Responsive",
        emojiBuilder: (w, h) => Assets.images.aDizzy.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Serene",
        emojiBuilder: (w, h) => Assets.images.yoga.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Sentimental",
        emojiBuilder: (w, h) =>
            Assets.images.thoughtBalloon.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Thankful",
        emojiBuilder: (w, h) =>
            Assets.images.slightlySmilingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Pensive",
        emojiBuilder: (w, h) => Assets.images.flower.image(width: w, height: h),
      ),
    ],
  ),
  EmotionCategory(
    title: "Mad",
    color: Color(0xFFfcd0c9),
    emojiBuilder: (w, h) => Assets.images.zanyFace.image(width: w, height: h),
    subEmotions: [
      SubEmotion(
        title: "Frustrated",
        emojiBuilder: (w, h) =>
            Assets.images.faceWithSteamFromNose.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Furious",
        emojiBuilder: (w, h) =>
            Assets.images.aFaceWithSymbolsOnMouth.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Irritated",
        emojiBuilder: (w, h) =>
            Assets.images.angryFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Jealous",
        emojiBuilder: (w, h) =>
            Assets.images.attitudeFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Selfish",
        emojiBuilder: (w, h) =>
            Assets.images.devilFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Hateful",
        emojiBuilder: (w, h) => Assets.images.fire.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Hostile",
        emojiBuilder: (w, h) => Assets.images.rage.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Angry",
        emojiBuilder: (w, h) =>
            Assets.images.angryRedFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Critical",
        emojiBuilder: (w, h) =>
            Assets.images.aFaceWithMonocle.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Hurt",
        emojiBuilder: (w, h) =>
            Assets.images.heartbreak.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Rage",
        emojiBuilder: (w, h) =>
            Assets.images.attitudeFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Annoyed",
        emojiBuilder: (w, h) =>
            Assets.images.faceWithUnimpressed.image(width: w, height: h),
      ),
      // SubEmotion(
      //   title: "Hostile",
      //   emojiBuilder: (w, h) =>
      //       Assets.images.zanyFace.image(width: w, height: h),
      // ),
    ],
  ),
  EmotionCategory(
    title: "Powerful",
    color: Color(0xFFdef9c8),
    emojiBuilder: (w, h) => Assets.images.flexed.image(width: w, height: h),
    subEmotions: [
      SubEmotion(
        title: "Proud",
        emojiBuilder: (w, h) =>
            Assets.images.lionFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Faithful",
        emojiBuilder: (w, h) =>
            Assets.images.aFoldedHands.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Appreciated",
        emojiBuilder: (w, h) =>
            Assets.images.huggingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Hopeful",
        emojiBuilder: (w, h) =>
            Assets.images.aRainbow.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Respected",
        emojiBuilder: (w, h) =>
            Assets.images.salutingFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Important",
        emojiBuilder: (w, h) => Assets.images.crown.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Worthwhile",
        emojiBuilder: (w, h) =>
            Assets.images.gemStone.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Intelligent",
        emojiBuilder: (w, h) => Assets.images.brain.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Confident",
        emojiBuilder: (w, h) =>
            Assets.images.glassesOnFace.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Satisfied",
        emojiBuilder: (w, h) =>
            Assets.images.smilingFaceWithSmilingEyes.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Cheerful",
        emojiBuilder: (w, h) =>
            Assets.images.celebration.image(width: w, height: h),
      ),
      SubEmotion(
        title: "Wonderful",
        emojiBuilder: (w, h) =>
            Assets.images.sparkles.image(width: w, height: h),
      ),
    ],
  ),
];
