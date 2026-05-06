/// 应用级常量
class AppConstants {
  AppConstants._();

  static const String appName = 'Papyrus';
  static const String appVersion = '0.1.0';

  // SM-2 默认值
  static const double defaultEasinessFactor = 2.5;
  static const int defaultRepetitions = 0;
  static const int defaultInterval = 0;
  static const int defaultNextReview = 0;

  // 评分映射
  static const int gradeForgot = 1;
  static const int gradeVague = 2;
  static const int gradeMastered = 3;

  // 学习界面
  static const Duration gradeDebounceDuration = Duration(milliseconds: 500);
  static const Duration dueCheckInterval = Duration(seconds: 5);

  // 目录名
  static const String backupsDirName = 'backups';
  static const String attachmentsDirName = 'attachments';

  // 备份策略
  static const Duration autoBackupInterval = Duration(hours: 1);

  // AI 默认值
  static const double defaultTemperature = 0.7;
  static const double defaultTopP = 0.9;
  static const int defaultMaxTokens = 2000;
  static const double defaultPresencePenalty = 0.0;
  static const double defaultFrequencyPenalty = 0.0;
  static const int defaultContextLength = 10;

  // 附件限制
  static const int maxAttachmentsPerMessage = 5;
  static const int maxAttachmentSizeBytes = 10 * 1024 * 1024; // 10MB

  // 请求超时
  static const Duration defaultApiTimeout = Duration(seconds: 60);
  static const Duration ollamaApiTimeout = Duration(seconds: 120);
}
