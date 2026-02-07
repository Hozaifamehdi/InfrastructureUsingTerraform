Azure Infrastructure using IaC technology using terraform

<h2>Naming Convenstion of <b>Azure Cloud</b></h2>

<h3>All the Resources must be follow this naming convenstion</h3>
<h6><org>-<env>-<region>-<workload/application>-<type>-<nn></h6>

<h4>Resource name must follow these rules: </h4>
1. Character are in Lowercase </br>
2. No Space</br>
3. No Special Character between name</br>
4. use - to distinguish </br>
5. name must be in between 3≤[org]-[env]-[region]-[workload]-[type]-[nn]≥ 24
   </br>
   </br>
   </br>
   <b>Definition of naming convention</b>
   <table>
    <tr>
        <td><b>Component</b></td>
        <td><b>Meaning</b></td>
    </tr>
    <tr>
        <td>Org</td>
        <td>Company Short Name</td>
    </tr>
    <tr>
        <td>Env</td>
        <td>Environment</td>
    </tr><tr>
        <td>Region</td>
        <td>Azure Region Code</td>
    </tr>
    <tr>
        <td>Workload/Application</td>
        <td>Application or Service Name</td>
    </tr>
    <tr>
        <td>Resource Type</td>
        <td>Resource Abbreviation</td>
    </tr>
    <tr>
        <td>Instance</td>
        <td>Number <b>use number if resource is more than one</b></td>
    </tr>
</table>

   <b>Exception resource which will not follow above naming convensiton</b>
   <table>
    <tr>
        <td><b>Resource Type</b></td>
        <td><b>Issue</b></td>
        <td><b>Naming Convenstion</b></td>
    </tr>
    <tr>
        <td>Storage Account</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
    <tr>
        <td>Container Registry</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
    <tr>
        <td>Key Vault</td>
        <td>24 char limit</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>SQL Server</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>App Service</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>Public IP DNS</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>Windows Hostname</td>
        <td>15 Char limit, no global uniqueness required</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>Front Door</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>Traffic Manager</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>CDN</td>
        <td>Global uniqueness</td>
        <td>a-z, 0-9</td>
    </tr>
        <tr>
        <td>AKS DNS Prefix </td>
        <td>DNS restriction</td>
        <td>a-z, 0-9</td>
    </tr>
  </table>

<b>for resource naming convenstion I have attached .docx file.</b>


<h2>Define your tagging requirements</h2>

<ol>
<li>A clear tagging strategy ensures your resources align with business goals and operational needs. Resource tags provide the foundation for cost management, governance, and automation across your Azure environment. You must assess your specific requirements to create effective tagging standards.</li>

<li>
Evaluate existing policies. Your Azure tagging approach must align with current organizational standards to maintain consistency. Inconsistent tagging creates confusion and reduces the effectiveness of resource management. To ensure your Azure tags complement these established practices, review your company's existing naming conventions and governance policies.</li>

<li>
Determine cost allocation needs. Tags support detailed cost tracking for chargeback or showback reporting across departments and business units. Identify whether you need granular cost allocation beyond the subscription level to support accurate billing and budget management. For more information, see Group and allocate costs using tag inheritance.</li>

<li>
Identify operational and compliance requirements. Resource tags capture critical operational metadata that supports automation and compliance reporting. Different resources require different operational details such as backup schedules, security classifications, or regulatory compliance status. Define which operational and compliance details your tags must track to support your requirements.</li>

<li>
Establish governance boundaries. Clear governance defines which tags are mandatory and which remain optional across your organization. Centralized IT policies typically enforce core tags while allowing teams flexibility for custom requirements. Determine your mandatory tag requirements and establish guidelines for optional tags to balance governance with team autonomy.
</li>
</ol>