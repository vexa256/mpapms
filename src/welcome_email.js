import emailjs from '@emailjs/browser';
import Swal from 'sweetalert2';

const sendEmail = async (recipientEmail, recipientName, userCode, password) => {
    const serviceID = 'service_xjdwxt8';
    const templateID = 'template_b8gvtwg';
    const userID = 'xWOiexQqcfZQ5cchR';

    const templateParams = {
        to_email: recipientEmail,
        to_name: recipientName,
        user_code: userCode,
        user_password: password,
    };

    try {
        await emailjs.send(serviceID, templateID, templateParams, userID);
        console.log('Email sent successfully');
    } catch (error) {
        console.error('Error sending email:', error);
        Swal.fire({
            title: 'Error',
            text: `Failed to send email: ${error.message}. Please check the console for more details.`,
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
};

export default sendEmail;
