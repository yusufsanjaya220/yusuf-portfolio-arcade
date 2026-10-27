import 'package:flutter/material.dart';

class ExperienceItem {
  final String id;
  final String positionId;
  final String positionEn;
  final String organization;
  final String periodId;
  final String periodEn;
  final String location;
  final String status; // 'ON GOING' or 'COMPLETED'
  final String summaryId;
  final String summaryEn;
  final List<String> bulletPointsId;
  final List<String> bulletPointsEn;
  final List<String> techStack;
  final ProjectShowcase? showcase;

  const ExperienceItem({
    required this.id,
    required this.positionId,
    required this.positionEn,
    required this.organization,
    required this.periodId,
    required this.periodEn,
    required this.location,
    required this.status,
    required this.summaryId,
    required this.summaryEn,
    required this.bulletPointsId,
    required this.bulletPointsEn,
    required this.techStack,
    this.showcase,
  });
}

class ProjectShowcase {
  final String titleId;
  final String titleEn;
  final String descriptionId;
  final String descriptionEn;
  final List<ApprovalWorkflowStep> approvalSteps;
  final List<String> highlights;

  const ProjectShowcase({
    required this.titleId,
    required this.titleEn,
    required this.descriptionId,
    required this.descriptionEn,
    required this.approvalSteps,
    required this.highlights,
  });
}

class ApprovalWorkflowStep {
  final String condition;
  final String approversId;
  final String approversEn;

  const ApprovalWorkflowStep({
    required this.condition,
    required this.approversId,
    required this.approversEn,
  });
}

class SkillItem {
  final String name;
  final int level; // 1 to 5
  final String noteId;
  final String noteEn;

  const SkillItem({
    required this.name,
    required this.level,
    required this.noteId,
    required this.noteEn,
  });
}

class SkillCategory {
  final String id;
  final String titleId;
  final String titleEn;
  final IconData icon;
  final List<SkillItem> skills;

  const SkillCategory({
    required this.id,
    required this.titleId,
    required this.titleEn,
    required this.icon,
    required this.skills,
  });
}

class CertificationItem {
  final String id;
  final String title;
  final String issuer;
  final String issueDate;
  final String credentialUrl;
  final List<String> tags;
  final String descriptionId;
  final String descriptionEn;

  const CertificationItem({
    required this.id,
    required this.title,
    required this.issuer,
    required this.issueDate,
    required this.credentialUrl,
    required this.tags,
    required this.descriptionId,
    required this.descriptionEn,
  });
}

class EducationItem {
  final String institution;
  final String majorId;
  final String majorEn;
  final String period;
  final String detailsId;
  final String detailsEn;
  final List<String> activities;

  const EducationItem({
    required this.institution,
    required this.majorId,
    required this.majorEn,
    required this.period,
    required this.detailsId,
    required this.detailsEn,
    this.activities = const [],
  });
}

class QuickHighlight {
  final String titleId;
  final String titleEn;
  final String valueId;
  final String valueEn;
  final IconData icon;
  final String badgeText;

  const QuickHighlight({
    required this.titleId,
    required this.titleEn,
    required this.valueId,
    required this.valueEn,
    required this.icon,
    required this.badgeText,
  });
}

class InGameAchievement {
  final String id;
  final String title;
  final String descriptionId;
  final String descriptionEn;
  final int triggerScore;
  final int triggerWave;
  bool isUnlocked;

  InGameAchievement({
    required this.id,
    required this.title,
    required this.descriptionId,
    required this.descriptionEn,
    this.triggerScore = 0,
    this.triggerWave = 0,
    this.isUnlocked = false,
  });
}
