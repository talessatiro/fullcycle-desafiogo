# Imagem base
FROM golang as go-build

# Diretório de trabalho
WORKDIR /go/src/app

# Copia o arquivo .go para o diretório de trabalho
COPY hello-world.go .

# Executa o build
RUN go build hello-world.go

# Segunda imagem para uso de multi stage building e otimização do tamanho
FROM scratch

# Copia da primeira imagem (golang) para a segunda (scratch) o arquivo binário gerado
COPY --from=go-build /go/src/app/hello-world .

# Executa o binário que imprime o resultado
ENTRYPOINT ["./hello-world"]