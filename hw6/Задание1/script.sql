-- Создание таблицы Subjects
CREATE TABLE [dbo].[Subjects] (
    [s_id]    INT           NOT NULL,
    [subjectname] NVARCHAR(50) NULL,
    PRIMARY KEY CLUSTERED ([s_id] ASC)
);

-- Создание таблицы StudentSubject
CREATE TABLE [dbo].[StudentSubject] (
    [st_id] INT NOT NULL,
    [s_id]  INT NOT NULL,
    PRIMARY KEY (st_id, s_id),
    FOREIGN KEY (st_id) REFERENCES [dbo].[students](st_id) ON DELETE CASCADE,
    FOREIGN KEY (s_id)  REFERENCES [dbo].[Subjects](s_id) ON DELETE CASCADE
);

