using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;

public class PathManager : MonoBehaviour
{
    public static string streamingAssetsPath()
    {
#if UNITY_EDITOR
        return Directory.GetCurrentDirectory() + "/bin/";
#elif UNITY_ANDROID
        return Application.persistentDataPath + "/WWW/";
#endif
    }
    public static string WWWstreamingAssetsPath()
    {
#if UNITY_EDITOR
        return "file:///" + Directory.GetCurrentDirectory() + "/bin/";
#elif UNITY_ANDROID
        return Application.persistentDataPath + "/WWW/";
#endif
    }
}