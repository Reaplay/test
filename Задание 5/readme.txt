т.к. скрипты нужно отлаживать на конкретном стенде, поэтому я только опишу примерно что должно происходить

5.2
запрашиваем пользовательские данные с помощью get-credentials, авторизовываемся
$cred = get-credentials
выполняем команды на удаленном сервере
Invoke-Command -ComputerName OscarTestApp -ScriptBlock {Stop-Process -InputObject | Get-Process -Name "ReportService"} -Credential $cred
Invoke-Command -ComputerName OscarTestApp -ScriptBlock {Get-ScheduledTask -TaskPath "\Report\Service" | Start-ScheduledTask -TaskName "ReportService"} -Credential $cred

5.3
Получаем список файлов в папке и заменяем строку

foreach ($file in Get-ChildItem -Path D:\Update\Report -Recurse -File -Filter *.rptdesign) {
	(Get-Content -Path 'D:\Update\Report\name_file.rptdesign') -replace 'prod/report_result?uuid=','test/report_result?uuid='
}
получаем кредлы и создаем сессию до ПК, копируем туда файлы. Для второго сервера делаем аналогично
$credentials = Get-Credential
$session = New-PSSession -HostName OscarProd01 -Credential $credentials
Copy-Item D:\Update\Report\*.rptdesign  /opt/IBM/profiles/report -ToSession $session
Invoke-Command -Session $session -ScriptBlock {chmod -R 644 /opt/IBM/profiles/report}
Invoke-Command -Session $session -ScriptBlock {chown -R RepResult:RepResult /opt/IBM/profiles/report}
Invoke-Command -Session $session -ScriptBlock {systemctl restart RepResultService}

