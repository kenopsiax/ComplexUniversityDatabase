--1 TABLO
--t�rk�e olan se�meli dersler
Select *
from Course
where CourseDescription='T�rk�e' AND CourseType='optional';



-- ofisi bornovada olan fak�lte �yeleri
Select *
from FacultyMember
where FM_Office='BORNOVA';


--kredisi 3ten b�y�k olan dersler
Select *
from Course
where Course.Credits > 3;




--2 TABLO

--tezi yapay zeka ile ilgili olan faculty member�n  ad� soyad�
SELECT FM_FirstName,FM_MiddleName,FM_LastName
FROM FacultyMember,Thesis
WHERE Thesis.Title='yapay zeka' AND WriterSSN=FM_SSN;




--her sectiondaki ��renci say�s�
SELECT Section.SectionID AS section_Id, COUNT(*) AS Number_of_students
FROM Section, TakenSection 
WHERE Section.SectionID = TakenSection.SectionID  
GROUP BY Section.SectionID;

--idsi 5 olan sectionda en y�ksek notu alan ��rencinin ad� soyad�
SELECT S_FirstName,S_LastName
FROM Student,TakenSection
WHERE TakenSection.SectionID=4 and Student.StudentID = TakenSection.StudentID and Grade = (
    SELECT Max(Grade)
    FROM TakenSection
	Where TakenSection.SectionID=4);

--master� olup doktoras� olmayan ��retim g�revlileri ad� soyad�
select FM_FirstName,FM_MiddleName,FM_LastName
from Thesis,FacultyMember
where ThesisType = 'master' and WriterSSN = FM_SSN and   WriterSSN NOT IN (select WriterSSN
                                                               from Thesis
                                                               Where  ThesisType = 'doktora');






--3TABLO
--software engineeringdeki b�t�n dersler

SELECT Course.CourseName
FROM Course,ComposedOf,Curriculum,Department
WHERE Department.DepartmentName='SOFTWARE ENGINEERING' AND Department.DepartmentCode=Curriculum.C_DepartmentCode 
AND Curriculum.CurriculumNo = ComposedOf.CurriculumNo AND ComposedOf.CourseCode=Course.CourseCode;




--python ile ilgili dersler
SELECT Course.CourseName
FROM Course,Keyword,CourseKeyword
WHERE Keyword.Word='PYTHON' and Keyword.KeywordId=CourseKeyword.C_KeywordID 
and CourseKeyword.CourseCode= Course.CourseCode;


--kaan berk altay�n ald��� dersler
select Course.CourseName
from TakenSection,Student, Section,Course
where Student.S_FirstName='Kaan' and Student.S_LastName='Altay' and Student.StudentId=TakenSection.StudentID and
Section.SectionID=TakenSection.SectionID and Section.Course_Code=Course.CourseCode;








--GEREKL� G�R�LEN SORGULAR


--Artificial intelligenceda �al��an faculty memberlar

SELECT FacultyMember.FM_FirstName,FacultyMember.FM_MiddleName, FacultyMember.FM_LastName
FROM Department,FacultyMember
WHERE Department.DepartmentName = 'ARTIFICIAL INTELLIGENCE' 
AND Department.DepartmentCode=FacultyMember.FM_DepartmentCode;


--her ara�t�rma alan�nda ka� tane fak�lte �yesinin �al��t���
SELECT  ResearchArea.Area AS research_area, COUNT(*) AS Number_of_faculty_members
FROM Researches,ResearchArea
Where Researches.AreaId=ResearchArea.AreaID
GROUP BY ResearchArea.Area;


--yapay zeka m�hendisli�i ile yaz�l�m m�hendisli�indeki ortak derslerin keywordleri

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