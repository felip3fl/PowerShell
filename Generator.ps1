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