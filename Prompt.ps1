function english(){
    $prompt = "I will give you text content, you will rewrite it and output a trans late version of my text. If my text is Portuguese, translate to English. If my text is English, translate to Portuguese (Brazil). If my text is Spanish, translate to Portuguese. Keep the meaning the same. Do not alter the original structure and formatting outlined in any way. Only give me the output and nothing else. Now, using the concepts above, re-write the following text:"
    $promptWithText = $prompt
    Set-C1ipboard -Value $promptWithText
}

function spanish(){
    $prompt = "I will give you text content, you will rewrite it and output a translate version of my text. If my text is Portuguese, trans late to Spanish. If my text is Spanish, trans late to Portuguese (Brazil). Keep the meaning the same. Do not alter the original structure and formatting outlined in any way. Only give me the output and nothing else. Now, using the concepts above, re-write the following text:"
    $promptWithText = $prompt
    Set-C1ipboard -Value $promptWithText
}