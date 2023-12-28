# Импорт библиотек
from flask import Flask, jsonify, request

# Инициализация Flask приложения
app = Flask(__name__)

# Пример базы данных (в данном случае - список для простоты)
transactions = []

# Эндпоинт для получения всех транзакций
@app.route('/transactions', methods=['GET'])
def get_transactions():
    return jsonify({'transactions': transactions})

# Эндпоинт для добавления новой транзакции
@app.route('/transactions', methods=['POST'])
def add_transaction():
    data = request.get_json()

    # Проверка наличия обязательных полей
    if 'description' not in data or 'amount' not in data:
        return jsonify({'error': 'Missing required fields'}), 400

    # Создание новой транзакции
    transaction = {
        'description': data['description'],
        'amount': data['amount']
    }

    # Добавление транзакции в базу данных
    transactions.append(transaction)

    return jsonify({'message': 'Transaction added successfully'}), 201

# Эндпоинт для удаления всех транзакций (для удобства)
@app.route('/transactions', methods=['DELETE'])
def delete_transactions():
    global transactions
    transactions = []
    return jsonify({'message': 'All transactions deleted successfully'}), 200

# Запуск приложения
if __name__ == '__main__':
    app.run(debug=True)
