using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChuiLeCube : MonoBehaviour {

    [SerializeField] List<GameObject> _faces;

    Rigidbody _rig;

    [SerializeField] float _rayDuration;
    [SerializeField] float _rayLenght;
    [SerializeField] float _detectionDelay;
    [SerializeField] float _force;
    [SerializeField] float _shift;

    bool _canDetect;

    private void OnEnable()
    {
        _rig = GetComponent<Rigidbody>();
        _canDetect = true;
        _shift /= 100;
    }

    private void Update()
    {
        if (_canDetect)
        {
            foreach (var item in _faces)
            {
                RaycastHit hit = new RaycastHit();
                List<GameObject> touchedItem = new List<GameObject>();

                if (Physics.Raycast(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(item.transform.lossyScale.x / 2 - _shift, item.transform.lossyScale.x / 2 - _shift, 0)),
                    item.transform.forward, out hit, _rayLenght))
                {
                    if(hit.collider.GetComponentInParent<AssignFaceColorByTag>() != null)
                    {
                        touchedItem.Add(hit.collider.GetComponentInParent<AssignFaceColorByTag>().gameObject);
                    }
                }
                Debug.DrawRay(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(item.transform.lossyScale.x / 2 - _shift, item.transform.lossyScale.x / 2 - _shift, 0)),
                    item.transform.forward * _rayLenght, Color.red, _rayDuration);

                if (Physics.Raycast(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(-item.transform.lossyScale.x / 2 + _shift, item.transform.lossyScale.x / 2 - _shift, 0)),
                    item.transform.forward, out hit, _rayLenght))
                {
                    if (hit.collider.GetComponentInParent<AssignFaceColorByTag>() != null)
                    {
                        touchedItem.Add(hit.collider.GetComponentInParent<AssignFaceColorByTag>().gameObject);
                    }
                }
                Debug.DrawRay(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(-item.transform.lossyScale.x / 2 + _shift, item.transform.lossyScale.x / 2 - _shift, 0)),
                    item.transform.forward * _rayLenght, Color.red, _rayDuration);

                if (Physics.Raycast(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(item.transform.lossyScale.x / 2 - _shift, -item.transform.lossyScale.x / 2 + _shift, 0)),
                    item.transform.forward, out hit, _rayLenght))
                {
                    if (hit.collider.GetComponentInParent<AssignFaceColorByTag>() != null)
                    {
                        touchedItem.Add(hit.collider.GetComponentInParent<AssignFaceColorByTag>().gameObject);
                    }
                }
                Debug.DrawRay(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(item.transform.lossyScale.x / 2 - _shift, -item.transform.lossyScale.x / 2 + _shift, 0)),
                    item.transform.forward * _rayLenght, Color.red, _rayDuration);

                if (Physics.Raycast(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(-item.transform.lossyScale.x / 2 + _shift, -item.transform.lossyScale.x / 2 + _shift, 0)),
                    item.transform.forward, out hit, _rayLenght))
                {
                    if (hit.collider.GetComponentInParent<AssignFaceColorByTag>() != null)
                    {
                        touchedItem.Add(hit.collider.GetComponentInParent<AssignFaceColorByTag>().gameObject);
                    }
                }
                Debug.DrawRay(item.transform.position + item.transform.InverseTransformDirection(
                    new Vector3(-item.transform.lossyScale.x / 2 + _shift, -item.transform.lossyScale.x / 2 + _shift, 0)),
                    item.transform.forward * _rayLenght, Color.red, _rayDuration);

                int goodtouch = new int();

                if (touchedItem.Count == 4)
                {
                    if (touchedItem[0] == touchedItem[1])
                    {
                        if (touchedItem[0] == touchedItem[2])
                        {
                            if (touchedItem[0] == touchedItem[3])
                            {
                                for (int i = 0; i < 4; i++)
                                {
                                    if (touchedItem[i].CompareTag(item.tag))
                                    {
                                        goodtouch++;
                                    }
                                }

                                if (goodtouch == 4)
                                {
                                    _rig.velocity = new Vector3(0, 0, 0) - item.transform.forward * _force;

                                    transform.position = touchedItem[0].transform.position + touchedItem[0].transform.forward.normalized / 4;

                                    StartCoroutine(DetectionDelay());
                                }
                            }
                        }
                    }
                }
            }
        }

        //Debug.Log(_rig.velocity);
    }

    IEnumerator DetectionDelay()
    {
        _canDetect = false;

        yield return new WaitForSeconds(_detectionDelay);

        _canDetect = true;
    }
}
