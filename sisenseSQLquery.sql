SELECT [Class Section]
	(
		CASE 
			WHEN Avg(pace) > 3.5
				THEN 1
			ELSE 0
		END)
FROM [Student Feedback Data]


SELECT [Class Section], 
	AVG(PACE) AS avg_pace
		FROM [Student Feedback Data]
GROUP BY [Class Section]


-- Take the averages from each 
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

-- This adds the risk filters
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
	AND feedback.avg_pace >4.5 
	OR feedback.avg_support <3 
	OR feedback.avg_selfmast<3 
	OR feedback.avg_engage < 3 
	OR feedback.avg_clarity < 3
	OR feedback.avg_knowledge < 3
	OR feedback.avg_lowsupport >= 0.1