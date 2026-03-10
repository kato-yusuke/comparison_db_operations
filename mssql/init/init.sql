CREATE DATABASE [test_db];
GO

USE [test_db];
GO

CREATE TABLE [test_table_1] (
    [id] INT NOT NULL IDENTITY(1,1),
    [bit] BIT,
    [bool] BIT,
    [tinyint] TINYINT,
    [smallint] SMALLINT,
    [mediumint] INT,
    [int] INT,
    [bigint] BIGINT,
    [decimal] DECIMAL(10,2),
    [float] FLOAT(10),
    [double] DOUBLE PRECISION,
    [date] DATE,
    [datetime] DATETIME,
    [timestamp] TIMESTAMP,
    [time] TIME,
    [year] DATE,
    [created_at] DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    [updated_at] DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    [char] CHAR,
    [varchar] VARCHAR(255),
    [binary] VARBINARY(max),
    [varbinary] VARBINARY(255),
    [tinyblob] VARBINARY(max),
    [blob] VARBINARY(max),
    [mediumblob] VARBINARY(max),
    [longblob] VARBINARY(max),
    [tinytext] VARCHAR(max),
    [text] VARCHAR(max),
    [mediumtext] VARCHAR(max),
    [longtext] VARCHAR(max),
    PRIMARY KEY (id)
);
GO
