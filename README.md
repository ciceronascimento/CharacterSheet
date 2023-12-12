# Cat & Dog Breeds Catalog App

Este é um aplicativo iOS que oferece um catálogo de raças de gatos e cachorros. Ele permite aos usuários explorar informações sobre diferentes raças de animais de estimação, incluindo fotos, temperamento e, quando disponíveis na API utilizada, a origem das raças. A solução foi desenvolvida para lidar com múltiplas APIs, oferecendo flexibilidade na obtenção de dados de fontes variadas.

## Problema e Solução

O desafio central enfrentado neste projeto era a integração de dados provenientes de APIs distintas para oferecer informações sobre as raças de gatos e cachorros. A solução adotada foi o desenvolvimento de views e funções flexíveis, capazes de receber e manipular dados provenientes das diferentes fontes por meio do uso de generics.

## Principais Funcionalidades

- **Integração de APIs:** As funções de requisição de API e os controladores de visualização foram desenvolvidos para serem compatíveis com múltiplas fontes de dados, permitindo a obtenção de informações de diferentes APIs de forma eficiente.
- **Injeção e Inversão de Dependência:** Implementação desses princípios para aumentar a modularidade e facilitar a manutenção do código.
- **Destaques Aleatórios:** Destaque de pets de forma aleatória para uma experiência mais dinâmica ao explorar o catálogo.
- **Exibição de Detalhes:** Mostra fotos, temperamentos e, quando disponível, informações de origem das raças de gatos e cachorros.

## Recursos Futuros (Com mais tempo estivesse disponível)

- **Feedback de Carregamento:** Implementação de indicadores visuais para informar o usuário sobre o carregamento de dados, melhorando a experiência do usuário.
- **Favoritos:** Capacidade para os usuários favoritarem seus pets preferidos. (Algumas implementações ja criadas)
- **Coleção de Favoritos:** Adição de uma coleção visual para visualizar e gerenciar os pets favoritados. (ScrollView/StackView ja adaptada para receber mais componentes)
- **Detalhes Adicionais em Sheet:** Expansão das informações disponíveis sobre os pets por meio de uma sheet contendo mais detalhes.

## Instalação

Para utilizar o aplicativo:

1. Clone este repositório.
2. Abra o projeto no Xcode.
3. Execute o aplicativo em um simulador ou dispositivo iOS.

## Tecnologias Utilizadas

- Swift
- UIKit
- URLSession para requisições HTTP

## Autor

[Cicero Nascimento]

---
