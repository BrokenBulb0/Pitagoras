#!/usr/bin/env python3.11

import tkinter as tk
from tkinter import ttk
import random
import os

# Constants
MIN_RANGE = -1000
MAX_RANGE = 1000

class PitagorasProblemGenerator:
    def __init__(self):
        self.generated_problems = set()

    def generate_reflection_problem(self, x_range, y_range, use_multiple_choice):
        while True:
            x = random.randint(x_range[0], x_range[1])
            y = random.randint(y_range[0], y_range[1])

            problem = f"Si el punto ({x},{y}) se refleja en torno al eje y, queda en el punto:"
            correct_answer = (-x, y)

            if use_multiple_choice:
                answer_options = [correct_answer]
                while len(answer_options) < 5:
                    option = (random.randint(x_range[0], x_range[1]), random.randint(y_range[0], y_range[1]))
                    if option != correct_answer and option not in answer_options:
                        answer_options.append(option)
                random.shuffle(answer_options)
                return problem, correct_answer, answer_options
            else:
                return problem, correct_answer

    def generate_rotation_problem(self, x_range, y_range, use_multiple_choice):
        while True:
            x = random.randint(x_range[0], x_range[1])
            y = random.randint(y_range[0], y_range[1])

            problem = f"Si el punto ({x},{y}) se gira en 90° en sentido antihorario en torno al origen, queda en el punto:"
            correct_answer = (-y, x)

            if use_multiple_choice:
                answer_options = [correct_answer]
                while len(answer_options) < 5:
                    option = (random.randint(x_range[0], x_range[1]), random.randint(y_range[0], y_range[1]))
                    if option != correct_answer and option not in answer_options:
                        answer_options.append(option)
                random.shuffle(answer_options)
                return problem, correct_answer, answer_options
            else:
                return problem, correct_answer

    def generate_translation_problem(self, x_range, y_range, use_multiple_choice):
        while True:
            x_start = random.randint(x_range[0], x_range[1])
            y_start = random.randint(y_range[0], y_range[1])
            x_translation = random.randint(MIN_RANGE, MAX_RANGE)
            y_translation = random.randint(MIN_RANGE, MAX_RANGE)

            x_end = x_start + x_translation
            y_end = y_start + y_translation

            problem = f"El punto ({x_start},{y_start}) se traslada quedando en el punto ({x_end},{y_end}), ¿cuál es la dirección de la traslación?"
            correct_answer = (x_translation, y_translation)

            if use_multiple_choice:
                answer_options = [correct_answer]
                while len(answer_options) < 5:
                    option_x = random.randint(MIN_RANGE, MAX_RANGE)
                    option_y = random.randint(MIN_RANGE, MAX_RANGE)
                    option = (option_x, option_y)
                    if option != correct_answer and option not in answer_options:
                        answer_options.append(option)
                random.shuffle(answer_options)
                return problem, correct_answer, answer_options
            else:
                return problem, correct_answer

    def generate_transformation_problem(self, x_range, y_range, use_multiple_choice):
        while True:
            x_start = random.randint(x_range[0], x_range[1])
            y_start = random.randint(y_range[0], y_range[1])
            x_translation = random.randint(MIN_RANGE, MAX_RANGE)
            y_translation = random.randint(MIN_RANGE, MAX_RANGE)

            x_end = x_start + x_translation
            y_end = y_start + y_translation

            problem = f"¿Cuál(es) de las siguientes transformaciones permite(n) que el punto ({x_start},{y_start}) quede en el punto ({x_end},{y_end})?"
            correct_answer = []

            reflection_x = (-x_start, y_start)
            reflection_origin = (-x_start, -y_start)
            translation = (x_translation, y_translation)
            translation_y = (0, y_translation)
            
            transformations = [(reflection_x, "Reflexión en torno al eje x"),
                               (reflection_origin, "Simetría puntual con respecto al origen"),
                               (translation, "Traslación en la dirección especificada"),
                               (translation_y, "Traslación en la dirección vertical")]

            for transformation, description in transformations:
                if transformation == (x_end, y_end):
                    correct_answer.append(description)

            if use_multiple_choice:
                answer_options = [description for _, description in transformations]
                random.shuffle(answer_options)
                return problem, correct_answer, answer_options
            else:
                return problem, correct_answer

class PitagorasApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Pitagoras")
        self.problem_generator = PitagorasProblemGenerator()
        self.create_ui()

    def create_ui(self):
        style = ttk.Style()
        style.configure('TButton', padding=(10, 5), font=('Helvetica', 12))
        style.configure('TLabel', font=('Helvetica', 12))
        style.configure('TCheckbutton', font=('Helvetica', 12))

        ttk.Label(self.root, text="Número de Problemas:", style='TLabel').grid(row=0, column=0)
        self.num_problems = ttk.Entry(self.root, font=('Helvetica', 12))
        self.num_problems.grid(row=0, column=1)

        ttk.Label(self.root, text="Tipos de Problemas:", style='TLabel').grid(row=1, column=0)

        self.reflection_var = tk.IntVar()
        self.reflection_check = ttk.Checkbutton(self.root, text="Transformaciones Isométricas", variable=self.reflection_var, style='TCheckbutton')
        self.reflection_check.grid(row=1, column=1)

        self.rotation_var = tk.IntVar()
        self.rotation_check = ttk.Checkbutton(self.root, text="Geometría de Proporción", variable=self.rotation_var, style='TCheckbutton')
        self.rotation_check.grid(row=2, column=1)

        self.translation_var = tk.IntVar()
        self.translation_check = ttk.Checkbutton(self.root, text="Vectores", variable=self.translation_var, style='TCheckbutton')
        self.translation_check.grid(row=3, column=1)

        self.transformation_var = tk.IntVar()
        self.transformation_check = ttk.Checkbutton(self.root, text="Geometría Analítica", variable=self.transformation_var, style='TCheckbutton')
        self.transformation_check.grid(row=4, column=1)

        ttk.Label(self.root, text="Rango de Valores (X, Y):", style='TLabel').grid(row=5, column=0)
        self.x_range_entry = ttk.Entry(self.root, font=('Helvetica', 12))
        self.x_range_entry.grid(row=5, column=1)
        self.x_range_entry.insert(0, "-1000,1000")

        self.y_range_entry = ttk.Entry(self.root, font=('Helvetica', 12))
        self.y_range_entry.grid(row=6, column=1)
        self.y_range_entry.insert(0, "-1000,1000")

        ttk.Label(self.root, text="¿Opciones Múltiples?", style='TLabel').grid(row=7, column=0)
        self.multiple_choice_var = tk.IntVar()
        self.multiple_choice_check = ttk.Checkbutton(self.root, variable=self.multiple_choice_var, style='TCheckbutton')
        self.multiple_choice_check.grid(row=7, column=1)

        ttk.Button(self.root, text="Generar Problemas", command=self.generate_problems, style='TButton').grid(row=8, column=0, columnspan=2)

        self.output_text = tk.Text(self.root, wrap=tk.WORD, width=80, height=20, font=('Helvetica', 12))
        self.output_text.grid(row=9, column=0, columnspan=2)

    def show_message(self, message, clear_input=False):
        self.output_text.delete(1.0, tk.END)
        self.output_text.insert(tk.END, message)

        if clear_input:
            self.num_problems.delete(0, tk.END)
            self.reflection_var.set(0)
            self.rotation_var.set(0)
            self.translation_var.set(0)
            self.transformation_var.set(0)
            self.x_range_entry.delete(0, tk.END)
            self.x_range_entry.insert(0, "-1000,1000")
            self.y_range_entry.delete(0, tk.END)
            self.y_range_entry.insert(0, "-1000,1000")
            self.multiple_choice_var.set(0)

    def validate_inputs(self):
        try:
            num_problems = int(self.num_problems.get())

            if num_problems <= 0:
                raise ValueError("El número de problemas debe ser mayor que cero.")

            selected_problem_types = []
            if self.reflection_var.get():
                selected_problem_types.append("reflection")
            if self.rotation_var.get():
                selected_problem_types.append("rotation")
            if self.translation_var.get():
                selected_problem_types.append("translation")
            if self.transformation_var.get():
                selected_problem_types.append("transformation")

            if not selected_problem_types:
                raise ValueError("Debes seleccionar al menos un tipo de problema.")

            use_multiple_choice = bool(self.multiple_choice_var.get())

            # Validate and parse the range values
            x_range_text = self.x_range_entry.get()
            y_range_text = self.y_range_entry.get()
            x_range = [int(val) for val in x_range_text.split(",")]
            y_range = [int(val) for val in y_range_text.split(",")]

            # Check range limits
            if len(x_range) != 2 or len(y_range) != 2:
                raise ValueError("Rango de valores incorrecto. Deben especificarse dos valores (mínimo y máximo) separados por coma para X y Y.")
            if x_range[0] < MIN_RANGE or x_range[1] > MAX_RANGE or y_range[0] < MIN_RANGE or y_range[1] > MAX_RANGE:
                raise ValueError("Los valores del rango deben estar entre -1000 y 1000.")

            return num_problems, selected_problem_types, use_multiple_choice, x_range, y_range

        except ValueError as e:
            self.show_message(f"Error: {str(e)}", clear_input=True)
            return None

    def generate_problems(self):
        inputs = self.validate_inputs()

        if inputs:
            num_problems, selected_problem_types, use_multiple_choice, x_range, y_range = inputs

            problems = []

            for problem_number in range(1, num_problems + 1):
                problem = ""
                correct_answer = None
                answer_options = None

                selected_type = random.choice(selected_problem_types)

                if selected_type == "reflection":
                    problem, correct_answer, answer_options = self.problem_generator.generate_reflection_problem(x_range, y_range, use_multiple_choice)
                elif selected_type == "rotation":
                    problem, correct_answer, answer_options = self.problem_generator.generate_rotation_problem(x_range, y_range, use_multiple_choice)
                elif selected_type == "translation":
                    problem, correct_answer, answer_options = self.problem_generator.generate_translation_problem(x_range, y_range, use_multiple_choice)
                elif selected_type == "transformation":
                    if use_multiple_choice:
                        problem, correct_answer, answer_options = self.problem_generator.generate_transformation_problem(x_range, y_range, use_multiple_choice)
                    else:
                        problem, correct_answer = self.problem_generator.generate_transformation_problem(x_range, y_range, use_multiple_choice)

                problems.append(f"{problem_number}. {problem}")

                if use_multiple_choice:
                    for i, option in enumerate(answer_options):
                        formatted_option = f"{chr(65 + i)}) Punto final: {option}"
                        problems.append(formatted_option)

                #if correct_answer is not None:
                    #problems.append(f"Respuesta Correcta: Punto final: {correct_answer}")

                problems.append("")

            output_file = os.path.join(os.path.dirname(os.path.abspath(__file__)), "Problemas_Pitagoras.txt")

            with open(output_file, "w") as file:
                file.write("\n".join(map(str, problems)))

            self.show_message(f"Problemas generados y guardados en 'Problemas_Pitagoras.txt'.", clear_input=True)


if __name__ == "__main__":
    root = tk.Tk()
    app = PitagorasApp(root)
    root.mainloop()
