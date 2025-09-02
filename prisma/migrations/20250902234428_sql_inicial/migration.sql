-- CreateEnum
CREATE TYPE "public"."Perfil" AS ENUM ('ADMIN', 'EMPRESA', 'CANDIDATO');

-- CreateTable
CREATE TABLE "public"."Usuario" (
    "id_usuario" SERIAL NOT NULL,
    "perfil" "public"."Perfil" NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senha" TEXT NOT NULL,
    "cpf" TEXT,
    "cnpj" TEXT,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "atualizado_em" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id_usuario")
);

-- CreateTable
CREATE TABLE "public"."Vaga" (
    "id_vaga" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "descricao" TEXT NOT NULL,
    "localizacao" TEXT,
    "salario" DOUBLE PRECISION,
    "data_publicacao" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id_empresa" INTEGER NOT NULL,

    CONSTRAINT "Vaga_pkey" PRIMARY KEY ("id_vaga")
);

-- CreateTable
CREATE TABLE "public"."Evento" (
    "id_evento" SERIAL NOT NULL,
    "titulo" TEXT NOT NULL,
    "localizacao" TEXT NOT NULL,
    "dataEvento" TIMESTAMP(3) NOT NULL,
    "criado_em" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "id_empresa" INTEGER NOT NULL,

    CONSTRAINT "Evento_pkey" PRIMARY KEY ("id_evento")
);

-- CreateTable
CREATE TABLE "public"."Token" (
    "id_token" SERIAL NOT NULL,
    "valor" TEXT NOT NULL,
    "tipo" TEXT NOT NULL,
    "usado_em" TIMESTAMP(3),
    "ativo" BOOLEAN NOT NULL DEFAULT true,
    "id_usuario" INTEGER NOT NULL,

    CONSTRAINT "Token_pkey" PRIMARY KEY ("id_token")
);

-- CreateTable
CREATE TABLE "public"."Sessao" (
    "id_sessao" TEXT NOT NULL,
    "id_usuario" INTEGER NOT NULL,
    "ativo" BOOLEAN NOT NULL,
    "data_criacao" TIMESTAMP(3) NOT NULL,
    "token" TEXT NOT NULL,

    CONSTRAINT "Sessao_pkey" PRIMARY KEY ("id_sessao")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "public"."Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_cpf_key" ON "public"."Usuario"("cpf");

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_cnpj_key" ON "public"."Usuario"("cnpj");

-- CreateIndex
CREATE UNIQUE INDEX "Token_valor_key" ON "public"."Token"("valor");

-- AddForeignKey
ALTER TABLE "public"."Vaga" ADD CONSTRAINT "Vaga_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "public"."Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Evento" ADD CONSTRAINT "Evento_id_empresa_fkey" FOREIGN KEY ("id_empresa") REFERENCES "public"."Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Token" ADD CONSTRAINT "Token_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "public"."Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Sessao" ADD CONSTRAINT "Sessao_id_usuario_fkey" FOREIGN KEY ("id_usuario") REFERENCES "public"."Usuario"("id_usuario") ON DELETE RESTRICT ON UPDATE CASCADE;
