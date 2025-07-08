function cpf($Quantidade = 1) {

    [bool]$Formatado = $false
        
    function Calculate-DigitoCPF {
        param([int[]]$Digitos, [int]$Posicao)
        
        $soma = 0
        $multiplicador = $Posicao + 1
        
        for ($i = 0; $i -lt $Posicao; $i++) {
            $soma += $Digitos[$i] * $multiplicador
            $multiplicador--
        }
        
        $resto = $soma % 11
        return ($resto -lt 2) ? 0 : (11 - $resto)
    }
    
    $cpfs = @()
    
    for ($i = 0; $i -lt $Quantidade; $i++) {
        # Gera os primeiros 9 dígitos aleatoriamente
        $digitos = @()
        for ($j = 0; $j -lt 9; $j++) {
            $digitos += Get-Random -Minimum 0 -Maximum 10
        }
        
        # Calcula o primeiro dígito verificador
        $digito1 = Calculate-DigitoCPF -Digitos $digitos -Posicao 9
        $digitos += $digito1
        
        # Calcula o segundo dígito verificador
        $digito2 = Calculate-DigitoCPF -Digitos $digitos -Posicao 10
        $digitos += $digito2
        
        # Converte para string
        $cpfString = -join $digitos
        
        # Formata se solicitado
        if ($Formatado) {
            $cpfFormatado = $cpfString.Substring(0, 3) + "." + 
            $cpfString.Substring(3, 3) + "." + 
            $cpfString.Substring(6, 3) + "-" + 
            $cpfString.Substring(9, 2)
            $cpfs += $cpfFormatado
        }
        else {
            $cpfs += $cpfString
        }
    }
    
    Set-Clipboard -Value $cpfs

    return $cpfs
}

function cnpj($Quantidade = 1) {
    
    $cnpjs = @()

    for ($i = 0; $i -lt $Quantidade; $i++) {
        $cnpj = ""
        for ($j = 0; $j -lt 8; $j++) {
            $cnpj += (Get-Random -Minimum 0 -Maximum 10)
        }
    
        # Adiciona código da filial (0001)
        $cnpj += "0001"
    
        # Calcula primeiro dígito verificador
        $multiplicadores1 = @(5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2)
        $soma1 = 0
        for ($k = 0; $k -lt 12; $k++) {
            $soma1 += [int]$cnpj[$k].ToString() * $multiplicadores1[$k]
        }
        $resto1 = $soma1 % 11
        $digito1 = if ($resto1 -lt 2) { 0 } else { 11 - $resto1 }
        $cnpj += $digito1
    
        # Calcula segundo dígito verificador
        $multiplicadores2 = @(6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2)
        $soma2 = 0
        for ($l = 0; $l -lt 13; $l++) {
            $soma2 += [int]$cnpj[$l].ToString() * $multiplicadores2[$l]
        }
        $resto2 = $soma2 % 11
        $digito2 = if ($resto2 -lt 2) { 0 } else { 11 - $resto2 }
        $cnpj += $digito2

        $cnpjs += $cnpj
    }
    
    Set-Clipboard -Value $cpfs

    return $cnpjs
}

function guid(){
    $guid = [guid]::NewGuid().ToString()
    Set-Clipboard -Value $guid
    return $guid
}

function upper($Texto) {
    # Pegar o valor do clipboard
    if (-not $Texto) {
        $Texto = Get-Clipboard
    }
    
    $textInfo = (Get-Culture).TextInfo
    $result = $textInfo.ToTitleCase($Texto.ToLower())

    Set-Clipboard -Value $textoConvertido
    return $result
}