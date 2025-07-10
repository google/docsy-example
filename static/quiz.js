function renderQuiz(containerId, quiz) {
  const container = document.getElementById(containerId);
  console.log("container: ", container)
  if (!container) return;
  let current = 0;
  let score = 0;

  function showQuestion(idx) {
    const q = quiz[idx];
    container.innerHTML = `
      <div class="quiz-question">${q.question}</div>
      <div class="quiz-options">
        ${q.options.map((opt, i) => `<button class='quiz-option' data-idx='${i}'>${opt}</button>`).join('')}
      </div>
      <div class="quiz-feedback"></div>
    `;
    container.querySelectorAll('.quiz-option').forEach(btn => {
      btn.onclick = function() {
        const selected = parseInt(this.getAttribute('data-idx'));
        const feedback = container.querySelector('.quiz-feedback');
        if (selected === q.answer) {
          score++;
          feedback.textContent = 'נכון!';
        } else {
          feedback.textContent = 'טעות';
        }
        setTimeout(() => {
          if (idx + 1 < quiz.length) {
            showQuestion(idx + 1);
          } else {
            container.innerHTML = `<div class='quiz-result'>תמו השאלות, התוצאה שלך: ${score}/${quiz.length}</div>`;
          }
        }, 800);
      };
    });
  }
  showQuestion(current);
}
// To use: renderQuiz('quiz-container', quizData); 