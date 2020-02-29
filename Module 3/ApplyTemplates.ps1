New-AzResourceGroup -Name "Training" -Location "East US"

New-AzResourceGroupDeployment -ResourceGroupName "Training" -TemplateUri "https://raw.githubusercontent.com/kkrivopishin/education/master/Module%203/main.json" -TemplateParameterUri "https://raw.githubusercontent.com/kkrivopishin/education/master/Module%203/parameters.json" -Verbose