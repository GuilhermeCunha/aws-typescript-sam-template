import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";
import { prepareResponse } from "../utils";

const acceptedMethods = ["POST"];

export const world = async (
  event: APIGatewayProxyEvent
): Promise<APIGatewayProxyResult> => {
  if (!acceptedMethods.includes(event.httpMethod)) {
    return prepareResponse({
      statusCode: 404,
      errors: [
        `This endpoint accepts ${acceptedMethods.join(
          ","
        )} method(s), you tried: ${event.httpMethod} method.`,
      ],
    });
  }
  // All log statements are written to CloudWatch
  console.info("received:", event);

  // Get id and name from the body of the request
  const body = JSON.parse(event.body as string);

  // All log statements are written to CloudWatch
  console.info(
    `3 response from: ${event.path} ${process.env.ExampleVariable2} `,
    body
  );
  return prepareResponse({
    statusCode: 200,
    body,
  });
};
