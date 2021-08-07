echo PowerShell

function Invoke-Format {
param(
        [Parameter(Mandatory=$true)]
        [Alias("dir")]
        [String] $directory
)
        $files = Get-ChildItem -Path $directory -File -Recurse -Include "*.hpp","*.cpp","*.h" |
        where {
          -not $_.FullName.Contains("thirdparty") -and
          -not $_.FullName.Contains("deps")
        }

        foreach ($file in $files) { clang-format -style=file -i $file.FullName } 
        echo "Done formatting all .(cpp|h|hpp) files in $directory"
}
