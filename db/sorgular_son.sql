--1 TABLO
--türkçe olan seçmeli dersler
Select *
from Course
where CourseDescription='Türkçe' AND CourseType='optional';



-- ofisi bornovada olan fakülte üyeleri
Select *
from FacultyMember
where FM_Office='BORNOVA';


--kredisi 3ten büyük olan dersler
Select *
from Course
where Course.Credits > 3;




--2 TABLO

--tezi yapay zeka ile ilgili olan faculty memberýn  adý soyadý
SELECT FM_FirstName,FM_MiddleName,FM_LastName
FROM FacultyMember,Thesis
WHERE Thesis.Title='yapay zeka' AND WriterSSN=FM_SSN;




--her sectiondaki öðrenci sayýsý
SELECT Section.SectionID AS section_Id, COUNT(*) AS Number_of_students
FROM Section, TakenSection 
WHERE Section.SectionID = TakenSection.SectionID  
GROUP BY Section.SectionID;

--idsi 5 olan sectionda en yüksek notu alan öðrencinin adý soyadý
SELECT S_FirstName,S_LastName
FROM Student,TakenSection
WHERE TakenSection.SectionID=4 and Student.StudentID = TakenSection.StudentID and Grade = (
    SELECT Max(Grade)
    FROM TakenSection
	Where TakenSection.SectionID=4);

--masterý olup doktorasý olmayan öðretim görevlileri adý soyadý
select FM_FirstName,FM_MiddleName,FM_LastName
from Thesis,FacultyMember
where ThesisType = 'master' and WriterSSN = FM_SSN and   WriterSSN NOT IN (select WriterSSN
                                                               from Thesis
                                                               Where  ThesisType = 'doktora');






--3TABLO
--software engineeringdeki bütün dersler

SELECT Course.CourseName
FROM Course,ComposedOf,Curriculum,Department
WHERE Department.DepartmentName='SOFTWARE ENGINEERING' AND Department.DepartmentCode=Curriculum.C_DepartmentCode 
AND Curriculum.CurriculumNo = ComposedOf.CurriculumNo AND ComposedOf.CourseCode=Course.CourseCode;




--python ile ilgili dersler
SELECT Course.CourseName
FROM Course,Keyword,CourseKeyword
WHERE Keyword.Word='PYTHON' and Keyword.KeywordId=CourseKeyword.C_KeywordID 
and CourseKeyword.CourseCode= Course.CourseCode;


--kaan berk altayýn aldýðý dersler
select Course.CourseName
from TakenSection,Student, Section,Course
where Student.S_FirstName='Kaan' and Student.S_LastName='Altay' and Student.StudentId=TakenSection.StudentID and
Section.SectionID=TakenSection.SectionID and Section.Course_Code=Course.CourseCode;








--GEREKLÝ GÖRÜLEN SORGULAR


--Artificial intelligenceda çalýþan faculty memberlar

SELECT FacultyMember.FM_FirstName,FacultyMember.FM_MiddleName, FacultyMember.FM_LastName
FROM Department,FacultyMember
WHERE Department.DepartmentName = 'ARTIFICIAL INTELLIGENCE' 
AND Department.DepartmentCode=FacultyMember.FM_DepartmentCode;


--her araþtýrma alanýnda kaç tane fakülte üyesinin çalýþtýðý
SELECT  ResearchArea.Area AS research_area, COUNT(*) AS Number_of_faculty_members
FROM Researches,ResearchArea
Where Researches.AreaId=ResearchArea.AreaID
GROUP BY ResearchArea.Area;


--yapay zeka mühendisliði ile yazýlým mühendisliðindeki ortak derslerin keywordleri

(select Word
from CourseKeyword,Keyword,Course,Department,Curriculum,ComposedOf
where Department.DepartmentCode = Curriculum.C_DepartmentCode AND 
Curriculum.CurriculumNo = ComposedOf.CurriculumNo
AND ComposedOf.CourseCode = Course.CourseCode AND 

Course.CourseCode=CourseKeyword.CourseCode AND 
CourseKeyword.C_KeywordID=Keyword.KeywordId AND Department.DepartmentCode=2)

UNION

(select Word
from CourseKeyword,Keyword,Course,Department,Curriculum,ComposedOf
where Department.DepartmentCode = Curriculum.C_DepartmentCode AND 
Curriculum.CurriculumNo = ComposedOf.CurriculumNo
AND ComposedOf.CourseCode = Course.CourseCode AND 

Course.CourseCode=CourseKeyword.CourseCode AND 
CourseKeyword.C_KeywordID=Keyword.KeywordId AND Department.DepartmentCode=3);