import { HttpsError } from "firebase-functions/v2/https";
import { GoogleGenAI } from "@google/genai";

export const getLanguageLabel = (langCode: string | number): string => {
  const supportedLangs = {
    vi: "Tiếng Việt (Vietnamese)",
    en: "English",
    // ja: "Japanese",
    // ko: "Korean",
    // fr: "French",
  };
  return (
    supportedLangs[String(langCode) as keyof typeof supportedLangs] || "English"
  );
};

export const getAIClient = (apiKey: string | undefined): GoogleGenAI => {
  if (!apiKey) {
    throw new HttpsError(
      "failed-precondition",
      "GEMINI_API_KEY is not configured.",
    );
  }
  return new GoogleGenAI({ apiKey });
};

export const generateContentFlash = async (
  apiKey: string | undefined,
  systemInstruction: string,
  contents: any,
) => {
  const ai = getAIClient(apiKey);
  return ai.models.generateContent({
    model: "gemini-3.1-flash-lite",
    contents,
    config: {
      systemInstruction,
    },
  });
};

export const generateContentFlashLite = async (
  apiKey: string | undefined,
  systemInstruction: string,
  contents: any,
) => {
  const ai = getAIClient(apiKey);
  return ai.models.generateContent({
    model: "gemini-3.1-flash-lite",
    contents,
    config: {
      systemInstruction,
    },
  });
};

