Shiny Application for Next Word Prediction

Introduction

•	The aim of this project is to create a Shiny application that predicts the next word in a sequence of text, mimicking the functionality seen in predictive text systems, such as those used in smartphone keyboards.

•	The project follows several steps:
1.	Understanding the problem and preparing the dataset,
2.	Conducting exploratory data analysis (EDA),
3.	Tokenizing the input text and building a prediction model,
4.	Compiling a milestone report,
5.	Developing and deploying the Shiny app for next-word prediction.

•	The data used for this project is publicly sourced, and after preprocessing, it was tokenized into n-grams (word sequences). These n-grams form the foundation for predicting the next word based on user input.

Data Preparation and Methods

•	Data Cleaning: The initial dataset underwent preprocessing, which included removing unnecessary elements such as punctuation, numbers, and stop words. Additionally, to ensure the application remains appropriate for all users, profanity words were also filtered out.

•	Tokenization: After cleaning, the text was tokenized into n-grams. N-grams represent sequences of n words that occur together in the text. This project uses unigrams, bigrams, trigrams, and quadgrams. These n-grams capture word sequences and their frequencies, which the prediction algorithm relies on.

•	Predictive Modeling: The n-gram frequency matrices were used to create the prediction model. By examining word combinations in the corpus, the model is able to predict the most likely next word in the sequence entered by the user. The prediction algorithm scans bigrams, trigrams, and quadgrams to make informed suggestions based on context.

Shiny Application

•	The Shiny application allows users to input a phrase and, in real-time, predicts the next possible word.

•	Functionality:

o	Users enter a sentence or phrase in the text box.

o	The app compares the user input with the n-gram models to predict the next word.

o	The prediction is instantly displayed as the user types, providing an option to use the suggested word.

•	The application is designed with a responsive user interface, ensuring that predictions refresh dynamically as more text is entered.

Model Performance and Evaluation

•	The performance of the n-gram model was tested against a separate dataset to assess its predictive accuracy. The evaluation involved comparing the suggested next word with the actual next word in the text.

•	The model's accuracy was compared across bigram, trigram, and quadgram predictions to ensure the highest possible level of accuracy in the predictions provided to users.

User Interface

•	The Shiny application features a simple and intuitive user interface:

•	The interface includes:

o	A text input field where users can enter a phrase or sentence,

o	A field that displays the predicted next word, which updates in real-time as the user types.

Conclusion

•	This Shiny app successfully provides an easy-to-use interface for predicting the next word in a sentence, utilizing n-gram models to analyze language patterns.

•	Future work could include improving the prediction accuracy by expanding the dataset or incorporating more advanced machine learning techniques, such as Recurrent Neural Networks (RNNs) or Transformer models. Enhancing the real-time performance of the application is also a consideration for future development.

