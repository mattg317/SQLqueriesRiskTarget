SELECT  risk.[University Name], risk.avg_pace, risk.avg_support, risk.avg_selfmast, risk.avg_engage, risk.avg_clarity, risk.avg_knowledge, risk.avg_lowsupport
FROM (	
	SELECT 
		feedback.[University Name], 
		AVG(feedback.Pace) AS avg_pace,
		AVG(feedback.support) AS avg_support,
		AVG(feedback.[Self-Mastery]) AS avg_selfmast,
		AVG(feedback.[Inst. Engagement]) AS avg_engage,
		AVG(feedback.[Inst. Clarity]) AS avg_clarity,
		avg(feedback.[Inst. Knowledge]) AS avg_knowledge,
		AVG(feedback.[Low Support]) AS avg_lowsupport
		FROM (
			SELECT [Student Feedback Data].[Class Section], [Student Feedback Data].[Pace], [Student Feedback Data].[Support], 
					[Student Feedback Data].[Self-Mastery], [Student Feedback Data].[Inst. Engagement], [Student Feedback Data].[Inst. Clarity], 
					[Student Feedback Data].[Inst. Knowledge], [Student Feedback Data].[Low Support], [Student Feedback Data].[At-Risk], 
					Class.[University Name], Class.[Start Date]
				FROM [Student Feedback Data]
					JOIN (
					
						SELECT University.[University Name], University.[Class Section], University.[Start Date]
							FROM (
								SELECT [universitiesCollection.csv].[University Name], [classesCollection.csv].[Class Section], 
										[classesCollection.csv].[Start Date] 
									FROM [universitiesCollection.csv] JOIN [classesCollection.csv]
									ON [classesCollection.csv].[University ID] = [universitiesCollection.csv].[University ID]
								) AS University
						) AS Class 
					ON [Student Feedback Data].[Class Section] = Class.[Class Section]
		) AS feedback
	GROUP BY feedback.[University Name]
)risk
WHERE 
	risk.avg_pace >4.5 
	OR risk.avg_support <3 
	OR risk.avg_selfmast<3 
	OR risk.avg_engage < 3.75 
	OR risk.avg_clarity < 3.75
	OR risk.avg_knowledge < 3.75
	OR risk.avg_lowsupport >= 0.1