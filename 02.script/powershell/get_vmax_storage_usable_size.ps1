# Set the VMAX REST API endpoint and credentials
$endpoint = "https:/IP:PORT/univmax/restapi"
$username = "USERNAME"
$password = "PASSWORD"

add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@

[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy

# Set the REST API request headers
$headers = @{
    "Authorization" = "Basic $([System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($username + ":" + $password)))"
    "Accept" = "application/json"
}

# Set the REST API request URL to query system information
$url = "$endpoint/92/sloprovisioning/symmetrix/{SYMETRIXID}"

# Send the REST API request to query system information
$response = Invoke-RestMethod -Uri $url -Headers $headers -Method Get
echo $response.system_capacity.usable_used_tb