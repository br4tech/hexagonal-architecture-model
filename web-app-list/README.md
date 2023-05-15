# Arquitetura Hexagonal com Ruby on Rails

Por outro lado, a arquitetura hexagonal, também conhecida como arquitetura de porta e adaptador, é uma abordagem de design de software que tem como objetivo criar sistemas mais modulares, flexíveis e testáveis. Ela separa o sistema em camadas distintas, cada uma com uma responsabilidade clara e bem definida. O núcleo do sistema é a camada de domínio, que contém as regras de negócio do sistema. Em torno do núcleo, existem as camadas de aplicação, que contêm a lógica da aplicação, e as camadas de infraestrutura, que lidam com a comunicação com o mundo externo. Essa divisão de camadas facilita a adição ou modificação de funcionalidades sem afetar outras partes do sistema.

## Benefícios da arquitetura hexagonal

**Modularidade:** A arquitetura hexagonal divide o sistema em módulos independentes, cada um com uma responsabilidade clara e bem definida. Isso torna mais fácil adicionar novos recursos ou alterar partes do sistema sem afetar outras áreas.

**Flexibilidade:** Como os módulos são independentes, é possível substituir um componente sem afetar todo o sistema. Isso permite que o software seja atualizado com mais facilidade e rapidez, e que seja mais fácil adicionar novos recursos.

**Testabilidade:** A arquitetura hexagonal torna mais fácil testar o sistema, pois cada módulo pode ser testado separadamente. Isso ajuda a identificar problemas e erros com mais rapidez, e a garantir a qualidade do software.

**Clareza:** A divisão em módulos e camadas facilita a compreensão do sistema e a localização de problemas. Isso torna mais fácil para os desenvolvedores entenderem como o software funciona e como ele pode ser melhorado.

**Reutilização de código:** Como os módulos são independentes, é mais fácil reutilizar código em diferentes partes do sistema. Isso ajuda a reduzir o tempo de desenvolvimento e a aumentar a eficiência da equipe.

## Como fazer a transição de um monolito para hexagonal

A transição de uma aplicação monolítica para uma arquitetura hexagonal pode ser um desafio, mas pode trazer muitos benefícios em termos de escalabilidade, manutenção e flexibilidade.

- *Compreenda a arquitetura hexagonal:* Antes de começar a transição, é importante ter uma compreensão clara da arquitetura hexagonal e como ela difere de uma aplicação monolítica. Recomendo que você leia mais sobre a arquitetura hexagonal e como ela pode beneficiar sua aplicação.

- *Identifique os componentes da sua aplicação:* Para começar a transição, você precisa identificar os componentes existentes da sua aplicação monolítica e definir quais deles serão os "núcleos" da sua arquitetura hexagonal. O objetivo é dividir sua aplicação em camadas separadas e independentes.

- *Crie portas e adaptadores:* Depois de identificar os componentes, crie as portas e adaptadores necessários para se comunicar com esses componentes. As portas são as interfaces de entrada e saída de sua aplicação e os adaptadores são responsáveis por conectar essas portas aos seus componentes. Você pode usar gemas de terceiros ou criar seus próprios adaptadores.

- *Refatore seu código:* Com as portas e adaptadores em vigor, é hora de refatorar seu código existente para funcionar dentro da arquitetura hexagonal. Isso pode envolver a separação de preocupações, como mover a lógica de negócios para a camada de domínio e a lógica de banco de dados para a camada de infraestrutura.

- *Teste e itere:* Após refatorar seu código, teste-o cuidadosamente para garantir que tudo esteja funcionando conforme o esperado. Se você encontrar problemas, itere e faça ajustes até que tudo esteja funcionando perfeitamente.

## Tech
- Ruby 2.7.0
- SQlite

## Setup

    rails c
    bundle install
    
