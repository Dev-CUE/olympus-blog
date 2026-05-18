param(
    [string]$Message = "content: $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
)

$VaultBlog = "G:\공유 드라이브\Olympus\shared\blog"
$QuartzContent = "C:\quartz-olympus\content"

Write-Host "shared\blog -> content 동기화 중..."

# 기존 content 정리 (index.md 제외)
Get-ChildItem $QuartzContent -Recurse -File |
    Where-Object { $_.FullName -notlike "*\index.md" } |
    Remove-Item -Force

# shared\blog 내용 복사
if (Test-Path $VaultBlog) {
    $items = Get-ChildItem $VaultBlog -Recurse
    foreach ($item in $items) {
        $rel = $item.FullName.Substring($VaultBlog.Length)
        $dest = Join-Path $QuartzContent $rel
        if ($item.PSIsContainer) {
            New-Item -ItemType Directory -Force $dest | Out-Null
        } else {
            Copy-Item $item.FullName $dest -Force
        }
    }
    Write-Host "동기화 완료: $($items.Count) 항목"
} else {
    Write-Host "경고: $VaultBlog 폴더를 찾을 수 없습니다."
}

# Git push
Set-Location "C:\quartz-olympus"
git add -A
$status = git status --porcelain
if ($status) {
    git commit -m $Message
    git push origin main
    Write-Host ""
    Write-Host "배포 시작! GitHub Actions에서 빌드 중..."
    Write-Host "사이트: https://dev-cue.github.io/olympus-blog"
} else {
    Write-Host "변경 사항 없음 — 배포 스킵"
}
