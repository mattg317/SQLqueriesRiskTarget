SELECT feedback.* 
FROM 
(
	SELECT [Class Section], 
		AVG(PACE) AS avg_pace,
		AVG(support) AS avg_support,
		AVG([Self-Mastery]) AS avg_selfmast,
		AVG([Inst. Engagement]) AS avg_engage,
		AVG([Inst. Clarity]) AS avg_clarity,
		avg([Inst. Knowledge]) AS avg_knowledge,
		AVG([Low Support]) AS avg_lowsupport
			FROM [Student Feedback Data]
	GROUP BY [Class Section]
)feedback
WHERE feedback.[Class Section] <> 'TRI-TEST-FSF'
	AND feedback.avg_pace <4.5 
	AND feedback.avg_support >3 
	AND feedback.avg_selfmast>3 
	AND feedback.avg_engage > 3 
	AND feedback.avg_clarity > 3
	AND feedback.avg_knowledge > 3
	AND feedback.avg_lowsupport <= 0.1
	AND (feedback.avg_pace > 4.25 AND feedback.avg_pace < 4.5) 
	OR (feedback.avg_support >3 AND feedback.avg_support<4)
	OR (feedback.avg_selfmast>3 AND feedback.avg_selfmast <3.25)
	OR (feedback.avg_engage > 3.5 AND feedback.avg_engage < 4) 
	OR (feedback.avg_clarity > 3.5 AND feedback.avg_clarity <4)
	OR (feedback.avg_knowledge > 3.5 AND feedback.avg_knowledge <4)
	OR (feedback.avg_lowsupport > 0.05 AND feedback.avg_lowsupport < 0.095)