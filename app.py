#app.py

#Teste de front Motorista
#Para executar o Front no navegador digite no terminal python app.py lembre-se o flask tem que está instalado 
from flask import Flask, request, redirect, url_for, render_template
import psycopg2
from psycopg2 import sql
from conectar_banco import ConectarBanco

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = 'uploads/'  # Pasta onde os arquivos serão salvos
app.config['MAX_CONTENT_LENGTH'] = 16 * 1024 * 1024  # Limite de 16 MB para uploads

def salvar_foto(file):
    try:
        caminho_foto = f"{app.config['UPLOAD_FOLDER']}/{file.filename}"
        file.save(caminho_foto)
        with open(caminho_foto, 'rb') as f:
            return f.read()
    except Exception as e:
        print(f"Erro ao salvar a foto: {e}")
        return None

@app.route('/', methods=['GET', 'POST'])
def upload_foto():
    if request.method == 'POST':
        nome = request.form['nome']
        telefone = request.form['telefone']
        linha_id = request.form['linha_id']
        empresa_id = request.form['empresa_id']

        foto = request.files['foto']
        if foto and foto.filename:
            foto_bin = salvar_foto(foto)
            if foto_bin:
                criar_motorista(nome, telefone, foto_bin, linha_id, empresa_id)
                return redirect(url_for('upload_foto'))
            else:
                return "Erro ao salvar a foto."
        else:
            return "Nenhuma foto fornecida."

    return render_template('upload.html')

def criar_motorista(nome, telefone, foto, linha_id, empresa_id):
    conexao = ConectarBanco()
    cursor = conexao.cursor()

    try:
        query = sql.SQL("""
            INSERT INTO Motorista (nome, telefone, foto, linha_id, empresa_id)
            VALUES (%s, %s, %s, %s, %s)
        """)
        cursor.execute(query, (nome, telefone, foto, linha_id, empresa_id))
        conexao.commit()
    except Exception as e:
        print(f"Erro ao criar motorista: {e}")
    finally:
        cursor.close()
        conexao.close()

if __name__ == "__main__":
    app.run(debug=True)
