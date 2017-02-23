SELECT [universitiesCollection.csv].[University Name], [classesCollection.csv].[Class Section], [classesCollection.csv].[Start Date]

FROM [universitiesCollection.csv] JOIN [classesCollection.csv]
ON [classesCollection.csv].[University ID] = [universitiesCollection.csv].[University ID]