SELECT Contras.Nm_Ct, telct.TelNum FROM `Contras` 
LEFT JOIN telct ON telct.CodCt = contras.CodCt
WHERE  telct.Respondent  = '' and telct.TelNum is not NULL


SELECT Contras.Nm_Ct, telct.TelNum FROM `Contras` 
LEFT JOIN telct ON telct.CodCt = contras.CodCt
WHERE  telct.TelNum is not NULL 


select sum(1) as ntel, contras.Nm_Ct from telct
left join contras on contras.CodCt = telct.CodCt
group by telct.CodCt,contras.Nm_Ct
HAVING ntel >=2


SELECT Contras.Nm_Ct FROM `Contras` 
LEFT JOIN telct ON telct.CodCt = contras.CodCt
WHERE telct.TelNum IS NULL