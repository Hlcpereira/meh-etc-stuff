# Problemas com Gitlab da Benner ao dar push/pull | Issues with Benner Gitlab when pushing or pulling

PT-BR:

Falta de SSH keys:

* Essa situação ocorre quando o Gitlab avisa que você não poderá dar push ou pull antes de adicionar uma SSH Key à sua conta.

Solução (Passo-a-passo):

- Abra o Git bash.
- Verifique se você está no diretório "/" (estará mostrando ao lado do MINGW64 em amarelo).
- Caso não esteja digite "cd /" e dê enter.
- Digite no terminal "usr/bin/ssh-keygen.exe"
- O terminal então irá mostrar aonde a sua SSH-Key será salva e perguntará se você deseja savlar em outro diretório. 
Caso não queira, dê enter, caso queira digite o caminho para o diretório que o arquivo com a SSH-Key e dê enter.
- Após isso o terminal pedirá para inserir uma senha. Detalhe: O BASH POR PADRÃO NÃO MOSTRARÁ A SENHA DIGITADA.
Caso queira deixar sem senha, somente dê um enter. O terminal perguntará pela confirmação, caso tenho digitado uma senha, repita-a e dê enter,
 se você não incluiu nenhuma senha, dê um enter somente.
- Abra o gerenciador de arquivo e procure pela pasta onde fora salva a SSH-Key e procure pelo arquivo id_rsa.pub, arquvio no qual estará suas keys públicas.
- Selecione todo o conteúdo do arquivo e copie.
- Abra o Giltab, vá nas configurações de sua conta e procure pela opções "SSH Keys". Cole a key que você havia copiado anteriormente e salve-a.
- Crie um/Vá até o repositório, verifique se fora dado o "link ssh" do repositório. Copie esse "link ssh" e tente dar git push usando ele (ou adicione ele como o remote "origin")
- That's all folks!

EN:

(Coming Soon)
