class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final double score;
  final String category;

  Answer(this.answerText, this.score, this.category);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here
  //1 / 1 c reverse
  list.add(Question(
    "I am clear about my feelings.",
    [
      Answer("Strongly Disagree", 5, 'CLARITY'),
      Answer("Disagree", 4, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 2, 'CLARITY'),
      Answer("Strongly Agree", 1, 'CLARITY'),
    ],
  ));
  //3 / 2 c reverse
  list.add(Question(
    "I pay attention to how I feel.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //4 / 3 cx
  list.add(Question(
    "I experience my emotions as overwhelming and out of control.",
    [
      Answer("Strongly Disagree", 1, 'IMPULSE'),
      Answer("Disagree", 2, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 4, 'IMPULSE'),
      Answer("Strongly Agree", 5, 'IMPULSE'),
    ],
  ));
  //5 / 4 c
  list.add(Question(
    "I have no idea how I am feeling.",
    [
      Answer("Strongly Disagree", 1, 'CLARITY'),
      Answer("Disagree", 2, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 4, 'CLARITY'),
      Answer("Strongly Agree", 5, 'CLARITY'),
    ],
  ));
  //6 / 5 c
  list.add(Question(
    "I have difficulty making sense out of my feelings.",
    [
      Answer("Strongly Disagree", 1, 'CLARITY'),
      Answer("Disagree", 2, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 4, 'CLARITY'),
      Answer("Strongly Agree", 5, 'CLARITY'),
    ],
  ));
  //7 / 6 c reverse
  list.add(Question(
    "I am attentive to my feelings.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //8 / 7 c reverse
  list.add(Question(
    "I know exactly how I am feeling.",
    [
      Answer("Strongly Disagree", 5, 'CLARITY'),
      Answer("Disagree", 4, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 2, 'CLARITY'),
      Answer("Strongly Agree", 1, 'CLARITY'),
    ],
  ));
  //9 / 8 c reverse
  list.add(Question(
    "I care about what I am feeling.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //10 / 9 cx
  list.add(Question(
    "I am confused about how I feel.",
    [
      Answer("Strongly Disagree", 1, 'CLARITY'),
      Answer("Disagree", 2, 'CLARITY'),
      Answer("Undecided", 3, 'CLARITY'),
      Answer("Agree", 4, 'CLARITY'),
      Answer("Strongly Agree", 5, 'CLARITY'),
    ],
  ));
  //12 / 10 c reverse
  list.add(Question(
    "When I'm upset, I acknowledge my emotions.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //14 / 11 c
  list.add(Question(
    "When I'm upset, I become angry with myself for feeling that way.",
    [
      Answer("Strongly Disagree", 1, 'NONACCEPTANCE'),
      Answer("Disagree", 2, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 4, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 5, 'NONACCEPTANCE'),
    ],
  ));
  //15 / 12 c
  list.add(Question(
    "When I'm upset, I become embarrassed for feeling that way.",
    [
      Answer("Strongly Disagree", 1, 'NONACCEPTANCE'),
      Answer("Disagree", 2, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 4, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 5, 'NONACCEPTANCE'),
    ],
  ));
  //16 / 13 c
  list.add(Question(
    "When I'm upset, I have difficulty getting work done.",
    [
      Answer("Strongly Disagree", 1, 'GOALS'),
      Answer("Disagree", 2, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 4, 'GOALS'),
      Answer("Strongly Agree", 5, 'GOALS'),
    ],
  ));
  //17 / 14 c
  list.add(Question(
    "When I'm upset, I become out of control.",
    [
      Answer("Strongly Disagree", 1, 'IMPULSE'),
      Answer("Disagree", 2, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 4, 'IMPULSE'),
      Answer("Strongly Agree", 5, 'IMPULSE'),
    ],
  ));
  //19 / 15 c
  list.add(Question(
    "When I'm upset, I believe that I will remain that way for a long time",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //20 / 16 c
  list.add(Question(
    "When I'm upset, I believe that I'll end up feeling very depressed.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //21 / 17 c reverse
  list.add(Question(
    "When I'm upset, I believe that my feelings are valid and important.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //22 / 18 c
  list.add(Question(
    "When I'm upset, I have difficulty focusing on other things.",
    [
      Answer("Strongly Disagree", 1, 'GOALS'),
      Answer("Disagree", 2, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 4, 'GOALS'),
      Answer("Strongly Agree", 5, 'GOALS'),
    ],
  ));
  //23 / 19 c
  list.add(Question(
    "When I'm upset, I feel out of control.",
    [
      Answer("Strongly Disagree", 1, 'IMPULSE'),
      Answer("Disagree", 2, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 4, 'IMPULSE'),
      Answer("Strongly Agree", 5, 'IMPULSE'),
    ],
  ));
  //24 / 20 c reverse
  list.add(Question(
    "When I'm upset, I can still get things done.",
    [
      Answer("Strongly Disagree", 5, 'GOALS'),
      Answer("Disagree", 4, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 2, 'GOALS'),
      Answer("Strongly Agree", 1, 'GOALS'),
    ],
  ));
  //25 / 21 c
  list.add(Question(
    "When I'm upset, I feel ashamed with myself for feeling that way.",
    [
      Answer("Strongly Disagree", 1, 'NONACCEPTANCE'),
      Answer("Disagree", 2, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 4, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 5, 'NONACCEPTANCE'),
    ],
  ));
  //26 / 22 c reverse
  list.add(Question(
    "When I'm upset, I know that I can find a way to eventually feel better.",
    [
      Answer("Strongly Disagree", 5, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 2, 'STRATEGIES'),
      Answer("Strongly Agree", 1, 'STRATEGIES'),
    ],
  ));
  //27 / 23 c
  list.add(Question(
    "When I'm upset, I feel like I am weak.",
    [
      Answer("Strongly Disagree", 1, 'NONACCEPTANCE'),
      Answer("Disagree", 2, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 4, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 5, 'NONACCEPTANCE'),
    ],
  ));
  //28 / 24 c
  list.add(Question(
    "When I'm upset, I feel like I can remain in control of my behaviors.",
    [
      Answer("Strongly Disagree", 5, 'IMPULSE'),
      Answer("Disagree", 4, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 2, 'IMPULSE'),
      Answer("Strongly Agree", 1, 'IMPULSE'),
    ],
  ));
  //29 / 25 c reverse
  list.add(Question(
    "When I'm upset, I feel guilty for feeling that way.",
    [
      Answer("Strongly Disagree", 1, 'NONACCEPTANCE'),
      Answer("Disagree", 2, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 4, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 5, 'NONACCEPTANCE'),
    ],
  ));
  //30 / 26 c
  list.add(Question(
    "When I'm upset, I have difficulty concentrating.",
    [
      Answer("Strongly Disagree", 1, 'GOALS'),
      Answer("Disagree", 2, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 4, 'GOALS'),
      Answer("Strongly Agree", 5, 'GOALS'),
    ],
  ));
  //31 / 27 c
  list.add(Question(
    "When I'm upset, I have difficulty controlling my behaviors.",
    [
      Answer("Strongly Disagree", 1, 'IMPULSE'),
      Answer("Disagree", 2, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 4, 'IMPULSE'),
      Answer("Strongly Agree", 5, 'IMPULSE'),
    ],
  ));
  //32 / 28 c
  list.add(Question(
    "When I'm upset, I believe that there is nothing I can do to make myself feel better.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //33 / 29 c
  list.add(Question(
    "When I'm upset, I become irritated with myself for feeling that way.",
    [
      Answer("Strongly Disagree", 1, 'NONACCEPTANCE'),
      Answer("Disagree", 2, 'NONACCEPTANCE'),
      Answer("Undecided", 3, 'NONACCEPTANCE'),
      Answer("Agree", 4, 'NONACCEPTANCE'),
      Answer("Strongly Agree", 5, 'NONACCEPTANCE'),
    ],
  ));
  //34 / 30 c
  list.add(Question(
    "When I'm upset, I start to feel very bad about myself.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //35 / 31 c
  list.add(Question(
    "When I'm upset, I believe that wallowing in it is all I can do.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //37 / 32 c
  list.add(Question(
    "When I'm upset, I lose control over my behaviors.",
    [
      Answer("Strongly Disagree", 1, 'IMPULSE'),
      Answer("Disagree", 2, 'IMPULSE'),
      Answer("Undecided", 3, 'IMPULSE'),
      Answer("Agree", 4, 'IMPULSE'),
      Answer("Strongly Agree", 5, 'IMPULSE'),
    ],
  ));
  //38 / 33 c
  list.add(Question(
    "When I'm upset, I have difficulty thinking about anything else.",
    [
      Answer("Strongly Disagree", 1, 'GOALS'),
      Answer("Disagree", 2, 'GOALS'),
      Answer("Undecided", 3, 'GOALS'),
      Answer("Agree", 4, 'GOALS'),
      Answer("Strongly Agree", 5, 'GOALS'),
    ],
  ));
  //39 / 34 c reverse
  list.add(Question(
    "When I'm upset, I take time to figure out what I'm really feeling.",
    [
      Answer("Strongly Disagree", 5, 'AWARENESS'),
      Answer("Disagree", 4, 'AWARENESS'),
      Answer("Undecided", 3, 'AWARENESS'),
      Answer("Agree", 2, 'AWARENESS'),
      Answer("Strongly Agree", 1, 'AWARENESS'),
    ],
  ));
  //40 / 35 c
  list.add(Question(
    "When I'm upset, it takes me a long time to feel better.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 2, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  //41 / 36 c
  list.add(Question(
    "When I'm upset, my emotions feel overwhelming.",
    [
      Answer("Strongly Disagree", 1, 'STRATEGIES'),
      Answer("Disagree", 4, 'STRATEGIES'),
      Answer("Undecided", 3, 'STRATEGIES'),
      Answer("Agree", 4, 'STRATEGIES'),
      Answer("Strongly Agree", 5, 'STRATEGIES'),
    ],
  ));
  return list;
}
