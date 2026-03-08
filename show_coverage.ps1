# Script: show_coverage.ps1
# الغرض: تشغيل اختبارات Flutter، توليد coverage، عرضها لكل ملف، وحساب النسبة الإجمالية

Write-Host "Running Flutter tests with coverage..." -ForegroundColor Cyan
flutter test --coverage

Write-Host "`nFormatting coverage report..." -ForegroundColor Cyan
dart pub global activate coverage | Out-Null

# طباعة التقرير لكل ملف
$coverageOutput = dart pub global run coverage:format_coverage `
    -i coverage `
    -o stdout `
    -r `
    --report-on=lib

Write-Host $coverageOutput

# حساب النسبة الإجمالية من lcov.info
$lcovPath = "coverage/lcov.info"
if (Test-Path $lcovPath)
{
    $lines = Get-Content $lcovPath
    $total = 0
    $covered = 0

    foreach ($line in $lines)
    {
        if ($line -match '^DA:(\d+),(\d+)')
        {
            $total += 1
            if ([int]$matches[2] -gt 0)
            {
                $covered += 1
            }
        }
    }

    if ($total -gt 0)
    {
        $percentage = [math]::Round(($covered / $total) * 100, 2)
        Write-Host "`nTotal coverage: $percentage%" -ForegroundColor Green
    }
    else
    {
        Write-Host "No coverage data found." -ForegroundColor Yellow
    }
}
else
{
    Write-Host "lcov.info file not found!" -ForegroundColor Red
}
