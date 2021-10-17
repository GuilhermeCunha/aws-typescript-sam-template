import { APIGatewayProxyEvent, APIGatewayProxyResult } from "aws-lambda";

export interface IPrepareResponse {
  statusCode: number;
  body?: any;
  errors?: string[];
}

export const prepareResponse = ({
  statusCode,
  body,
  errors,
}: IPrepareResponse): APIGatewayProxyResult => {
  const responseBody = errors
    ? {
        errors,
      }
    : body;
  return {
    statusCode,
    body: JSON.stringify(responseBody),
  };
};

export const verifyAcceptedMethods = (
  acceptedMethods: string[],
  event: APIGatewayProxyEvent
) => {
  if (!acceptedMethods.includes(event.httpMethod)) {
    return prepareResponse({
      statusCode: 404,
      errors: [
        `This endpoint only accepts ${acceptedMethods.join(
          ","
        )} method(s), you tried: ${event.httpMethod} method.`,
      ],
    });
  }
};
