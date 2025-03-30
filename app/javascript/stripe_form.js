document.addEventListener('DOMContentLoaded', function() {
  console.log('Document ready');
  if (typeof jQuery !== 'undefined') {
    console.log('jQuery is loaded');
  }

  // 予約フォームが存在する場合のみ実行
  if ($('#card-element').length) {
    console.log('Card element found');
    
    if (!window.stripeKey) {
      console.error('Stripe key is not set');
      return;
    }
    console.log('Using Stripe key:', window.stripeKey);

    const stripe = Stripe(window.stripeKey);
    console.log('Stripe initialized');

    const elements = stripe.elements();
    console.log('Stripe elements created');
    
    // カード入力フォームのスタイル
    const style = {
      base: {
        fontSize: '16px',
        color: '#32325d',
        fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
        '::placeholder': {
          color: '#aab7c4'
        }
      },
      invalid: {
        color: '#fa755a',
        iconColor: '#fa755a'
      }
    };

    // カード入力フォームの作成とマウント
    const card = elements.create('card', {style: style});
    console.log('Card element created');

    card.mount('#card-element');
    console.log('Card element mounted');

    // エラーハンドリング
    card.addEventListener('change', function(event) {
      console.log('Card input changed', event);
      
      const displayError = $('#card-errors');
      if (event.error) {
        console.log('Card error:', event.error.message);
        displayError.text(event.error.message);
      } else {
        console.log('Card input valid');
        displayError.text('');
      }
    });
  } else {
    console.log('Card element not found');
  }
}); 