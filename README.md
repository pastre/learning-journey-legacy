# Learning Journey
[![codebeat badge](https://codebeat.co/badges/54d1c65f-27b4-4ae1-96c8-5f6576be12b9)](https://codebeat.co/projects/github-com-pastre-learning-journey-main)
[![Build Status](https://travis-ci.com/pastre/learning-journey.svg?branch=main)](https://travis-ci.com/pastre/learning-journey)

Esse app é a minha proposta para melhorar a experiência cotidiana de atualizar a Learning Journey

Ah, também quero aprender SwiftUI, Clean Architecture e como criar um projeto maneiro open source

### Milestones

✔️ Design e implementação de uma tela que lista as trilhas

✔️ Design e implementação de uma tela que lista os objetivos de uma trilha

✔️ Alimentar app com dados do AirTable

✔️ Swiftlint + swiftformat

❌ Snapshot tests de Views e Components

❌ Testes unitários dos módulos de sistema

❌ Testes unitários dos módulos dos interactors

❌ Testes unitários dos módulos dos repositórios

❌ Testes unitários dos utilitários

❌ O Academer precisa setar seu nível de expertise em um objetivo

❌ O Academer precisa importar o Basic Knowledge da Academy

❌ O Academer precisa ver o seu progresso

❌ O Academer precisa pesquisar objetivos

❌ O Academer precisa filtrar objetivos

❌ O Academer precisa ver o seu progresso

❌ Os mentores precisam acompanhar o progresso dos alunos

### Tem uma ideia?
Maneiro! Abre um Issue com a tag [PITCH] pra gente conversar :)

### Quero contribuir
Uhul! Da um bizu no [Figma](https://www.figma.com/file/i92HNfoVmYhOIu01ShYAgT/Learning-Journey?node-id=0%3A1) se quiser melhorar aspectos de UI

Ta mais pra código? Confere o [manual de contribuições](CONTRIBUTING.md)

Achou um bug, tem uma proposta, algo que está errado, ou uma ideia inovadora? Abre um issue

### Arquitetura

Pensei em usar VIPER, mas a navegação em SwiftUI dispensa o uso de um `Router`

Pensei em user VIP, mas o fluxo de dados no SwiftUI é extremamente acoplado com um suporte nativo de estado das views, o que faria do `Presenter` só um proxy bobo

Escolhi o MVVM justamente por essa ressonância que ele tem com o Combine e o ViewState. 

Se estiver com dúvidas, de uma olhada nesse [blog post](https://nalexn.github.io/clean-architecture-swiftui/?utm_source=nalexn_github). Boa parte das inspirações vieram dali
