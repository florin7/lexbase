-- CreateTable
CREATE TABLE "Codice" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "slug" TEXT NOT NULL,
    "nome" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "Libro" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "codiceId" TEXT NOT NULL,
    "ordine" INTEGER NOT NULL,
    "label" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    CONSTRAINT "Libro_codiceId_fkey" FOREIGN KEY ("codiceId") REFERENCES "Codice" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Titolo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "libroId" TEXT NOT NULL,
    "ordine" INTEGER NOT NULL,
    "label" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    CONSTRAINT "Titolo_libroId_fkey" FOREIGN KEY ("libroId") REFERENCES "Libro" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Capo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "titoloId" TEXT NOT NULL,
    "ordine" INTEGER NOT NULL,
    "label" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    CONSTRAINT "Capo_titoloId_fkey" FOREIGN KEY ("titoloId") REFERENCES "Titolo" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Sezione" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "capoId" TEXT NOT NULL,
    "ordine" INTEGER NOT NULL,
    "label" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    CONSTRAINT "Sezione_capoId_fkey" FOREIGN KEY ("capoId") REFERENCES "Capo" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Articolo" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "codiceId" TEXT NOT NULL,
    "libroId" TEXT,
    "titoloId" TEXT,
    "capoId" TEXT,
    "sezioneId" TEXT,
    "numero" TEXT NOT NULL,
    "rubrica" TEXT,
    "slug" TEXT NOT NULL,
    "testo" TEXT NOT NULL,
    "commiJson" JSONB,
    "embedding" JSONB,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Articolo_codiceId_fkey" FOREIGN KEY ("codiceId") REFERENCES "Codice" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Articolo_libroId_fkey" FOREIGN KEY ("libroId") REFERENCES "Libro" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Articolo_titoloId_fkey" FOREIGN KEY ("titoloId") REFERENCES "Titolo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Articolo_capoId_fkey" FOREIGN KEY ("capoId") REFERENCES "Capo" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT "Articolo_sezioneId_fkey" FOREIGN KEY ("sezioneId") REFERENCES "Sezione" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Codice_slug_key" ON "Codice"("slug");

-- CreateIndex
CREATE INDEX "Libro_codiceId_ordine_idx" ON "Libro"("codiceId", "ordine");

-- CreateIndex
CREATE UNIQUE INDEX "Libro_codiceId_slug_key" ON "Libro"("codiceId", "slug");

-- CreateIndex
CREATE INDEX "Titolo_libroId_ordine_idx" ON "Titolo"("libroId", "ordine");

-- CreateIndex
CREATE UNIQUE INDEX "Titolo_libroId_slug_key" ON "Titolo"("libroId", "slug");

-- CreateIndex
CREATE INDEX "Capo_titoloId_ordine_idx" ON "Capo"("titoloId", "ordine");

-- CreateIndex
CREATE UNIQUE INDEX "Capo_titoloId_slug_key" ON "Capo"("titoloId", "slug");

-- CreateIndex
CREATE INDEX "Sezione_capoId_ordine_idx" ON "Sezione"("capoId", "ordine");

-- CreateIndex
CREATE UNIQUE INDEX "Sezione_capoId_slug_key" ON "Sezione"("capoId", "slug");

-- CreateIndex
CREATE INDEX "Articolo_codiceId_numero_idx" ON "Articolo"("codiceId", "numero");

-- CreateIndex
CREATE INDEX "Articolo_rubrica_idx" ON "Articolo"("rubrica");

-- CreateIndex
CREATE UNIQUE INDEX "Articolo_codiceId_slug_key" ON "Articolo"("codiceId", "slug");
