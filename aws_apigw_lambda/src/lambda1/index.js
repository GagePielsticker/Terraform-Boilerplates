exports.handler = async (event, context) => {
  // Log the incoming event for debugging purposes
  console.log('Received event:', JSON.stringify(event, null, 2));

  // Your core logic goes here
  const message = 'Hello from Lambda!';

  // Construct the response object
  const response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ message: message }),
  };

  // Return the response
  return response;
};