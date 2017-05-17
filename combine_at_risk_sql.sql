SELECT risk.UniversityName, risk.ClassSection_SectionID, risk.avg_pace, risk.avg_support,
 risk.avg_selfmast, risk.avg_engage, risk.avg_clarity, risk.avg_knowledge, risk.avg_lowsupport, risk.ClassSectionName
FROM (	
	SELECT 
		feedback.UniversityName,
		feedback.ClassSection_SectionID,
		feedback.ClassSectionName, 
		AVG(feedback.Pace) AS avg_pace,
		AVG(feedback.support) AS avg_support,
		AVG(feedback.[Self-Mastery]) AS avg_selfmast,
		AVG(feedback.[Inst. Engagement]) AS avg_engage,
		AVG(feedback.[Inst. Clarity]) AS avg_clarity,
		avg(feedback.[Inst. Knowledge]) AS avg_knowledge,
		AVG(feedback.LowSupport) AS avg_lowsupport
		FROM (
			SELECT [combined_student_feedback_final].ClassSection_SectionID, [combined_student_feedback_final].[Pace],[combined_student_feedback_final].[Support], 
					[combined_student_feedback_final].[Self-Mastery], [combined_student_feedback_final].[Inst. Engagement], [combined_student_feedback_final].[Inst. Clarity], [combined_student_feedback_final].[Inst. Knowledge], [combined_student_feedback_final].LowSupport, [combined_student_feedback_final].AtRisk, Class.UniversityName, Class.ClassSectionName
				FROM [combined_student_feedback_final]
					RIGHT JOIN (					
						SELECT University.UniversityName, University.ClassSectionName, University.ClassSection_SectionID
							FROM (
								SELECT [combined_classes_universities].UniversityName, [combined_classes_universities].ClassSectionName, 
										[combined_classes_universities].ClassSection_SectionID
									FROM [combined_classes_universities]
								) AS University
						) AS Class 
					ON [combined_student_feedback_final].ClassSection_SectionID = Class.ClassSection_SectionID
		) AS feedback
	GROUP BY feedback.UniversityName, feedback.ClassSection_SectionID, feedback.ClassSectionName
)risk
WHERE risk.ClassSection_SectionID != 'TRI-TEST-FSF'
	AND (risk.avg_pace >4.5 
	OR risk.avg_support <3 
	OR risk.avg_selfmast<3 
	OR risk.avg_engage < 3.75 
	OR risk.avg_clarity < 3.75
	OR risk.avg_knowledge < 3.75
	OR risk.avg_lowsupport >= 0.1)
