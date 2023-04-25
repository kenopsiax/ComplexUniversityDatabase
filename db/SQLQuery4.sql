CREATE TABLE Course_keywords (
    keyword_id int NOT NULL,
    course_code varchar(255)NOT NULL,
	PRIMARY KEY(keyword_id,course_code)
);